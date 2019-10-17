//
//  Cache.swift
//  RandomUser
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

final class Cache {
    
    
    func saveToDisk(
        users: [User],
        withName name: String = "users",
        using fileManager: FileManager = .default
    ) throws {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        let data = try JSONEncoder().encode(users)
        try data.write(to: fileURL)
    }
    
    
    func loadFromDisk(
        withName name: String = "users",
        using fileManager: FileManager = .default
    ) throws -> [User] {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        
        let data = try Data(contentsOf: fileURL)
        let model = try JSONDecoder().decode([User].self, from: data)
        return model
    }
    
    
    func isFilePersisted(
        withName name: String = "users",
        using fileManager: FileManager = .default
    ) -> Bool {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        return fileManager.fileExists(atPath: fileURL.path)
    }
    
}
