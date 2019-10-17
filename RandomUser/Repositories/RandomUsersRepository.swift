//
//  RandomUsersRepository.swift
//  RandomUser
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models
import RandomUserKit

class RandomUsersRepository {
    
    private let service: ServiceType
    private let cacheService: CacheService
    
    init(service: ServiceType, cacheService: CacheService) {
        self.service = service
        self.cacheService = cacheService
    }
}

extension RandomUsersRepository: RandomUsersRepositoryType {
    
    func fetch(results number: Int? = nil, completion: @escaping (Result<[User], Error>) -> Void) {
        service.fetchUsers(results: number) { response  in
            switch response {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveToDisk(users: [User]) throws {
           try cacheService.saveToDisk(users: users)
       }
       
       func loadFromDisk() throws -> [User] {
           try cacheService.loadFromDisk()
       }
       
       func removeFile() throws {
           try cacheService.removeFile()
       }
       
       
       func isFilePersisted() -> Bool {
           return cacheService.isFilePersisted()
       }
    
}

