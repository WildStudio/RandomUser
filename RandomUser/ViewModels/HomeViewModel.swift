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
}

class HomeViewModel {
    
    private let repository: RandomUsersRepositoryType
    private var users: [User]?
    
    private(set) var title = "Random Users"
    
    weak var delegate: HomeViewModelDelegate?
    
    
    init(repository: RandomUsersRepositoryType) {
        self.repository = repository
    }
    
    
    func performFetching() {
        repository.fetch(results: 50) { [weak self] result in
            self?.handleResult(result)
        }
    }
    
    
    func handleResult(_ result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            self.users = users
            delegate?.viewModelFetched(users: users)
        case .failure(let error):
            print(error)
        }
    }
    
}
