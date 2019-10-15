//
//  HomeViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import Models
import RandomUserKit

class HomeViewController: UIViewController {
    
    private enum Constant {
        static let cellReuseIdentifier = "cell"
    }
    
    
    @IBOutlet private var tableView: UITableView!
    private var emptyStateController: EmptyStateViewController?
    var viewModel = HomeViewModel(repository: RandomUsersRepository(service: Service(serverConfig: ServerConfig(apiBaseUrl: URL(string: "https://randomuser.me/")!))))
    
    var users: [User] = [] {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        viewModel.performFetching()
        //
        //        let emptyStateController = EmptyStateViewController()
        //        self.emptyStateController = emptyStateController
        //        emptyStateController.delegate = self
        //        addChild(emptyStateController)
        //        view.addSubview(emptyStateController.view)
        //        emptyStateController.didMove(toParent: self)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emptyStateController?.view.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func numberOfRows(inSection section: Int) -> Int {
        return users.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellReuseIdentifier)
            else { return UITableViewCell() }
        
        cell.textLabel?.text = users[indexPath.row].name?.first
        return cell
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    
    func viewModelFetched(users: [User]) {
        self.users = users
    }
    
}

extension HomeViewController: EmptyStateViewControllerDelegate {
    
    func emptyStatesViewControllerTappedMainButton() {
        viewModel.performFetching()
        print("Tapped main button")
    }
    
}

