//
//  HomeViewModelDelegate.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

protocol HomeViewModelDelegate: AnyObject {
    func onFetchCompleted(with users: [User])
    func deletedItem(at index: Int, users: [User])
    func onFetchFailed(with reason: String)
}
