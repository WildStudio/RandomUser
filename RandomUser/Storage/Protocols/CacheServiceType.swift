//
//  CacheServiceType.swift
//  RandomUser
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

protocol CacheServiceType {
    
    associatedtype Model
    
    
    func saveToDisk(
        users: [Model],
        withName name: String ,
        using fileManager: FileManager
    ) throws
    
    
    func loadFromDisk(
        withName name: String,
        using fileManager: FileManager
    ) throws -> [Model]
    
    
    func removeFile(withName name: String,
                    using fileManager: FileManager
    ) throws
    
    
    func isFilePersisted(
        withName name: String,
        using fileManager: FileManager
    ) -> Bool
    
}
