//
//  HomeViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import Models
import SDWebImage
import RandomUserKit

class HomeViewController: UIViewController {
    
    private enum Constant {
        static let cellReuseIdentifier = "cell"
        static let searchBarPlaceholder = "Start typing to filter users..."
    }
    
    @IBOutlet private var tableView: UITableView!
    
    let search = UISearchController(searchResultsController: nil)
    private var emptyStateController: EmptyStateViewController?
    private var viewModel: HomeViewModelType?
    
    private var filteredData = [User]()
    private var users: [User] = [] {
        didSet { tableView.reloadData() }
    }
    
    private var isSearchBarEmpty: Bool {
        search.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        search.isActive && !isSearchBarEmpty
    }
    
    lazy var emptyCell = UITableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        viewModel?.delegate = self
        viewModel?.performFetching()
        title = viewModel?.title
    }
    
    
    func configure(with viewModel: HomeViewModelType) {
        self.viewModel = viewModel
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ThumbnailTableViewCell.self, forCellReuseIdentifier: Constant.cellReuseIdentifier)
    }
    
    
    private func setupSearchController() {
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = Constant.searchBarPlaceholder
        navigationItem.searchController = search
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emptyStateController?.view.frame = view.bounds
    }
    
}

// MARK: - Table view data source

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { return filteredData.count }
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.cellReuseIdentifier
            ) as? ThumbnailTableViewCell
            else { return emptyCell }
        
        let user: User
        
        if isFiltering {
            user = filteredData[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        
        cell.configure(with: user)
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard !isFiltering else { return }
        if editingStyle == .delete {
            viewModel?.removeUser(at: indexPath.row)
        }
    }
    
}

// MARK: - View Model delegate

extension HomeViewController: HomeViewModelDelegate {
    
    func onFetchFailed(with reason: String) {
        
    }
    
    
    func deletedItem(at index: Int, users: [User]) {
        tableView.beginUpdates()
        self.users = users
        tableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .top)
        tableView.endUpdates()
    }
    
    
    func onFetchCompleted(with users: [User]) {
        self.users = users
    }
    
}

extension HomeViewController: EmptyStateViewControllerDelegate {
    
    func emptyStatesViewControllerTappedMainButton() {
        viewModel?.performFetching()
    }
    
}

// MARK: - UISearchResultsUpdating

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
            else { return }
        filteredData = viewModel?.updateSearchResults(for: text) ?? []
        tableView.reloadData()
    }
    
}


private extension HomeViewController {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let viewModel = self.viewModel
            else { return false }
        return indexPath.row >= viewModel.users.count
    }
    
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel?.performFetching()
        }
        
    }
    
}
