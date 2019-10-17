//
//  HomeViewModelDelegate.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

protocol ListViewModelDelegate: AnyObject {
    func onFetchCompleted()
    func deletedItem(at index: Int)
    func onFetchFailed(with reason: String)
}
