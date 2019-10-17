//
//  ListViewModelType.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

protocol ListViewModelType {
    
    var delegate: HomeViewModelDelegate? { get set }
    var title: String { get }
    var blacklist: [Blacklisted] { get }
    var users: Set<User> { get }
    var userIDs: Set<UUID> { get }
    
    func showEmptyState() -> Bool
    func viewModel(for user: User) -> UserViewModelType
    func remove(user: User, at index: Int)
    func updateSearchResults(for text: String) -> [User]
    func insertBlacklisted(_ user: User) -> Bool
    func userIsBlackListed(_ user: User) -> Bool
    func performFetching()
    func loadRemoteData()
    func handleResult(_ result: Result<[User], Error>)
    
}
