//
//  HomeViewModelType.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

protocol HomeViewModelType {
    
    var delegate: HomeViewModelDelegate? { get set }
    var title: String { get }
    var blacklisted: [User] { get }
    var users: [User] { get }
    var userIDs: Set<UUID> { get }
    
    func removeUser(at index: Int)
    func updateSearchResults(for text: String) -> [User]
    func insertBlacklisted(_ user: User) -> Bool
    func userIsBlackListed(_ user: User) -> Bool
    func performFetching()
    func handleResult(_ result: Result<[User], Error>)
    
}
