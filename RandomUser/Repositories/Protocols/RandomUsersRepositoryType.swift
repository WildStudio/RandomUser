//
//  RandomUsersRepositoryType.swift
//  RandomUser
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

protocol RandomUsersRepositoryType {
    func fetch(results number: Int?, completion: @escaping (Result<[User], Error>) -> Void)
}
