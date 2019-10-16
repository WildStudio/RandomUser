//
//  HomeViewModel.swift
//  RandomUser
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

protocol HomeViewModelDelegate: AnyObject {
    func viewModelFetched(users: [User])
    func deletedItem(at index: Int, users: [User]) 
}

class HomeViewModel {
    
    private enum Constant {
        static let navigationBarTitle = "Random Users"
        static let results = 50
    }
    
    typealias blacklist = (user: User, userID: UUID)
    
    private var blacklisted = [User]()
    private var users = [User]()
    private var userIDs = Set<UUID>()
    private let repository: RandomUsersRepositoryType
    private(set) var title = Constant.navigationBarTitle
    
    weak var delegate: HomeViewModelDelegate?
    
    
    init(repository: RandomUsersRepositoryType) {
        self.repository = repository
    }
    
    
    func performFetching() {
        repository.fetch(
            results: Constant.results
        ) { [weak self] result in
            self?.handleResult(result)
        }
    }
    
    
    func removeUser(at index: Int) {
        guard let user = users[safe: index] else { return }
        
        if insertBlacklisted(user) {
            users.remove(at: index)
            delegate?.deletedItem(at: index, users: users)
        }
    }
    
    
    private func handleResult(_ result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            self.users = users.filter { !self.userIsBlackListed($0) }
            delegate?.viewModelFetched(users: self.users)
        case .failure(let error):
            // TODO: handle the error
            print(error)
        }
    }
    
}

extension HomeViewModel {
    
    /// Returns a Boolean value that indicates whether a given user  can be inserted into the blacklist..
    func insertBlacklisted(_ user: User) -> Bool {
        blacklisted.append(user)
        guard let ID = user.userUUID
            else { return false }
        let inserted = userIDs.insert(ID).inserted
        return inserted ? true : false
    }
    
    
    func userIsBlackListed(_ user: User) -> Bool {
        guard let ID = user.userUUID
            else { return false }
        return userIDs.contains(ID)
    }
    
}
