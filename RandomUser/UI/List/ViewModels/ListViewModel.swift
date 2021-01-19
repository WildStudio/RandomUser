//
//  ListViewModel.swift
//  RandomUser
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models
import os

typealias Blacklisted = (user: User, userID: UUID)

final class ListViewModel: ViewStateProviding {
    
    private enum Constant {
        static let results = 50
        static let navigationBarTitle = "Random Users"
    }
    
    enum Event {
        case idle
        case deletedItem(at: Int)
    }

    
    private(set) var filteredData = [User]()
    private(set) var blacklist = [Blacklisted]()
    private(set) var users = Set<User>()
    private(set) var userIDs = Set<UUID>()
    private(set) var title = Constant.navigationBarTitle
    private(set) var isFetching: Bool = false
    
    private let repository: RandomUsersRepositoryType
    
    // MARK: - ViewStateEmitting

    var onViewStateChange: ((ViewState<Void>) -> Void)?

    private(set) var viewState: ViewState<Void> = .empty {
        didSet {
            DispatchQueue.main.async {
                self.onViewStateChange?(self.viewState)
            }
        }
    }
    
    // MARK: - EventEmitting

    var onEvent: ((Event) -> Void)?

    private(set) var event: Event = .idle {
        didSet {
            DispatchQueue.main.async {
                self.onEvent?(self.event)
            }
        }
    }
    
    
    var usersArray: [User] {
        Array(users)
    }
    
    
    init(repository: RandomUsersRepositoryType) {
        self.repository = repository
    }
    
    func showEmptyState() -> Bool {
        !repository.isFilePersisted()
    }
    
    
    func initialize() {
        viewState = .loading
        repository.isFilePersisted() ? loadLocalStore() : loadRemoteData()
    }
    
    
    func loadRemoteData() {
        guard !isFetching else { return }
        isFetching = true
        repository.fetch(
            results: Constant.results
        ) { [weak self] result in
            self?.handleResult(result)
        }
    }
    
    
    /// Returns a `UserViewModel`
    ///- Parameters:
    ///     - isFiltering: Whether the view is in search mode or not.
    ///     - index: the given index  tapped
    func viewModel(at index: Int, isFiltering: Bool) -> UserViewModelType? {
        guard let user = isFiltering ? filteredData[safe: index] : usersArray[safe: index]
            else { return .none }
        return UserViewModel(user: user)
    }
    
    
    /// Returns a `ThumbnailCellViewModel`
    ///- Parameters:
    ///     - isFiltering: Whether the view is in search mode or not.
    ///     - index: the given index  tapped
    func thumbnailCellViewModel(at index: Int, isFiltering: Bool) -> ThumbnailCellViewModel? {
        guard let user = isFiltering ? filteredData[safe: index] : usersArray[safe: index]
            else { return nil }
        return ThumbnailCellViewModel(user)
    }
    
    
    /// Filter the user list with a given string with a search scope that includes name, surname and email
    /// - Parameters:
    ///     - text: the filter term
    func updateSearchResults(for text: String) {
        
        // We first filter based on name, username, and email:
        let nameResults = users
            .filter { ($0.name?.first.lowercased().contains(text.lowercased()) ?? false) }
        let surnameResults = users
            .filter { ($0.name?.last.lowercased().contains(text.lowercased()) ?? false) }
        let emailResults = users
            .filter { ($0.email?.lowercased().contains(text.lowercased()) ?? false) }
        
        // Then we combine them.
        let unionNameAndSurname = nameResults.union(surnameResults)
        let union = unionNameAndSurname.union(emailResults)
        
        // Finally convert to an Array & set filtered data
        filteredData = Array(union)
        
    }
    
    
    /// Safely access to the user with index inserted in the blacklist and if the insertion is succesful delete the user and notify.
    /// - Parameters:
    ///     - user: the user to be removed
    ///     - index: the array lookup index.
    func remove(user: User, at index: Int) {
        if insertBlacklisted(user) {
            users.remove(user)
            store(usersArray)
            event = .deletedItem(at: index)
        }
    }
    
    
    /// Handle the results, to filter them down from the blacklisted ones and remove duplicates.
    /// - Parameters:
    ///     - result: A value that represents either a success or a failure, including an associated value in each case.
    func handleResult(_ result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            isFetching = false
            let usersSet = Set(users).filter { !userIsBlackListed($0) }
            self.users = self.users.union(usersSet)
            store(usersArray)
            viewState = .ready
        case .failure(let error):
            isFetching = false
            viewState = .error(error)
        }
    }
    
    
    private func store(_ users: [User]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            do {
                try self?.repository.saveToDisk(users: users)
            } catch let error {
                os_log(
                    "Can't store users",
                    log: Log.cache,
                    type: .error,
                    error.localizedDescription
                )
            }
        }
    }
    
}

// MARK: - Blacklisting

extension ListViewModel {
    
    /// Returns a Boolean value that indicates whether a given user  can be inserted into the blacklist.
    func insertBlacklisted(_ user: User) -> Bool {
        guard let ID = user.userUUID
            else { return false }
        
        blacklist.append((user, ID))
        let inserted = userIDs.insert(ID).inserted
        return inserted ? true : false
    }
    
    
    func userIsBlackListed(_ user: User) -> Bool {
        guard let ID = user.userUUID
            else { return false }
        return userIDs.contains(ID)
    }
    
}

// MARK: - Local Store (Cache)

extension ListViewModel {
    
    private func loadLocalStore() {
        var users = [User]()
        
        // Try to load local data
        do {
            users = try repository.loadFromDisk()
        } catch let error {
            os_log("Can't load data", log: Log.cache, type: .error, error.localizedDescription)
        }
        
        // If none users are given back delete disk file
        if users.count == .zero {
            removeLocalStore()
        }
        
        viewState = .ready
        self.users = Set(users)
    }
    
    
    private func removeLocalStore() {
        do {
            try repository.removeFile()
        }  catch let error {
            os_log(
                "Can't delete local data",
                log: Log.cache,
                type: .error, error.localizedDescription
            )
        }
    }
    
}
