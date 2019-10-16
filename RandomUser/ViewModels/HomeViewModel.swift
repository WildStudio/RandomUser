//
//  HomeViewModel.swift
//  RandomUser
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

class HomeViewModel: HomeViewModelType {
    
    private enum Constant {
        static let navigationBarTitle = "Random Users"
        static let results = 50
    }
    
    typealias blacklist = (user: User, userID: UUID)
    
    private(set) var blacklisted = [User]()
    private(set) var users = [User]()
    private(set) var userIDs = Set<UUID>()
    private(set) var title = Constant.navigationBarTitle
    private(set) var isFetching: Bool = false
    
    private let repository: RandomUsersRepositoryType
    
    weak var delegate: HomeViewModelDelegate?
    
    
    init(repository: RandomUsersRepositoryType) {
        self.repository = repository
    }
    
    
    func performFetching() {
        guard !isFetching else { return }
        isFetching = true
        repository.fetch(
            results: Constant.results
        ) { [weak self] result in
            self?.handleResult(result)
        }
    }
    
    /// Filter the user list with a given string with a search scope that includes name, surname and email
    /// - Parameters:
    ///     - text: the filter term
    func updateSearchResults(for text: String) -> [User] {
        
        // We first filter based on name, username, and email :
        let nameResults = users
            .filter { ($0.name?.first?.lowercased().contains(text.lowercased()) ?? false) }
        let surnameResults = users
            .filter { ($0.name?.last?.lowercased().contains(text.lowercased()) ?? false) }
        let emailResults = users
            .filter { ($0.email?.lowercased().contains(text.lowercased()) ?? false) }
        
        // Then we convert each array to a set to be able to combine them.
        let set = Set(nameResults)
        let unionNameAndSurname = set.union(surnameResults)
        let union = unionNameAndSurname.union(emailResults)
        
        // Finally convert to an Array
        return Array(union)
        
    }
    
    /// Safely access to the user with index inserted in the blacklist and if the iserion is succesful delete the user and notify.
    /// - Parameters:
    /// - index: the array lookup index.
    func removeUser(at index: Int) {
        guard let user = users[safe: index] else { return }
        
        if insertBlacklisted(user) {
            users.remove(at: index)
            delegate?.deletedItem(at: index, users: users)
        }
    }
    
    /// Handle the results, to filter them down from the blacklisted ones and remove duplicates.
    /// - Parameters:
    /// - result: A value that represents either a success or a failure, including an associated value in each case.
    func handleResult(_ result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            isFetching = false
            let newUsers = users
                .filter { !self.userIsBlackListed($0) }
                .uniqueElements
            self.users.append(contentsOf: (newUsers))
            delegate?.onFetchCompleted(with: self.users)
        case .failure(let error):
            isFetching = false
            delegate?.onFetchFailed(with: error.localizedDescription)
        }
    }
    
}


extension HomeViewModel {
    
    /// Returns a Boolean value that indicates whether a given user  can be inserted into the blacklist.
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
