//
//  ListViewModelType.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

protocol ListViewModelType: EventEmitting {
    
    var title: String { get }
    var filteredData: [User] { get }
    var blacklist: [Blacklisted] { get }
    var users: Set<User> { get }
    var usersArray: [User] { get }
    var userIDs: Set<UUID> { get }
    
    var onEvent: ((EventType) -> Void)? { get }
    var onViewStateChange: ((ViewState<Void>) -> Void)? { get set }
    
    func initialize()
    func showEmptyState() -> Bool
    func viewModel(at index: Int, isFiltering: Bool) -> UserViewModelType?
    func thumbnailCellViewModel(at index: Int, isFiltering: Bool) -> ThumbnailCellViewModel?
    func remove(user: User, at index: Int)
    func updateSearchResults(for text: String)
    func insertBlacklisted(_ user: User) -> Bool
    func userIsBlackListed(_ user: User) -> Bool
    func loadRemoteData()
    func handleResult(_ result: Result<[User], Error>)
    
}
