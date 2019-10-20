//
//  ListViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import Models
import SDWebImage

final class ListViewController: UIViewController, AlertControllerDisplayer {
    
    private enum Constant {
        static let cellReuseIdentifier = "cell"
        static let alertTitle = "Something went wrong"
        static let alertOK = "OK"
        static let searchBarPlaceholder = "Start typing to filter users..."
        static let showDetailView = "showdetail"
        static let prefetchingCell = 5
    }
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private var search: UISearchController?
    private var viewModel: ListViewModelType?
    lazy private var emptyStateController = EmptyStateViewController()
    
    
    private var isSearchBarEmpty: Bool {
        search?.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        search?.isActive ?? false && !isSearchBarEmpty
    }
    
    lazy var emptyCell = UITableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.delegate = self
        title = self.viewModel?.title
        setupTableView()
        setupSearchController()
        guard let viewModel = viewModel else { return }
        viewModel.showEmptyState() ? addEmptyState() : viewModel.performFetching()
    }
    
    
    func configure(with viewModel: ListViewModelType) {
        self.viewModel = viewModel
    }
    
    
    private func setupTableView() {
        tableView.prefetchDataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.register(ThumbnailTableViewCell.self, forCellReuseIdentifier: Constant.cellReuseIdentifier)
    }
    
    
    private func addEmptyState() {
        emptyStateController.delegate = self
        embed(emptyStateController)
        embedView(emptyStateController.view, in: view)
    }
    
    
    private func removeEmptyState() {
        remove(emptyStateController)
    }
    
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        search = searchController
        search?.searchResultsUpdater = self
        search?.obscuresBackgroundDuringPresentation = false
        search?.searchBar.placeholder = Constant.searchBarPlaceholder
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        search?.searchBar.isHidden = true
    }
    
}

// MARK: - Table view data source & Delegate

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel,
            let userViewModel = viewModel.viewModel(at: indexPath.row, isFiltering: isFiltering),
            let controller = DetailViewController.instantiate()
            else { return }
        controller.configure(with: userViewModel)
        show(controller, sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        if isFiltering { return viewModel.filteredData.count }
        return viewModel.usersArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.cellReuseIdentifier
            ) as? ThumbnailTableViewCell,
            let viewModel = viewModel,
            let thumbnailCellViewModel = viewModel.thumbnailCellViewModel(at: indexPath.row, isFiltering: isFiltering)
            else { return emptyCell }
    
        
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else  {
            cell.configure(with: thumbnailCellViewModel)
        }
        
        return cell
    }
    
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard !isFiltering,
            let viewModel = viewModel else { return }
        if editingStyle == .delete {
            viewModel.remove(user: viewModel.usersArray[indexPath.row], at: indexPath.row)
        }
    }
    
}

// MARK: - View Model delegate

extension ListViewController: ListViewModelDelegate {
    
    func onFetchFailed(with reason: String) {
        activityIndicator.stopAnimating()
        let action = UIAlertAction(title: Constant.alertOK, style: .default)
        displayAlert(with: Constant.alertTitle , message: reason, actions: [action])
    }
    
    
    func deletedItem(at index: Int) {
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .top)
        tableView.endUpdates()
    }
    
    
    func onFetchCompleted() {
        activityIndicator.stopAnimating()
        search?.searchBar.isHidden = false
        tableView.isHidden = false
        removeEmptyState()
        tableView.reloadData()
    }
    
}

extension ListViewController: EmptyStateViewControllerDelegate {
    
    func emptyStatesViewControllerTappedMainButton() {
        viewModel?.performFetching()
    }
    
}

// MARK: - UISearchResultsUpdating

extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
            else { return }
        viewModel?.updateSearchResults(for: text)
        tableView.reloadData()
    }
    
}


extension ListViewController: UITableViewDataSourcePrefetching {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let viewModel = self.viewModel
            else { return false }
        return indexPath.row >= viewModel.users.count - Constant.prefetchingCell
    }
    
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel?.loadRemoteData()
        }
    }
    
}

