//
//  MockRandomUserService.swift
//  RandomUserTests
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import RandomUserKit
import Models
@testable import RandomUser

struct MockServerConfig: ServerConfigType {
    public var apiBaseUrl: URL = URL(string: "https://randomuser.me/")!
}

class MockRandomUserService: ServiceType {
    
    var serverConfig: ServerConfigType
    
    required init(serverConfig: ServerConfigType) {
        self.serverConfig = serverConfig
    }
    
    func fetchUsers(
        results: Int?,
        completion: @escaping (Result<[User], Error>) -> Void
    ) {
        completion(.success([MockConstant.user]))
    }
    
}
