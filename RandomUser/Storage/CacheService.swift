//
//  Cache.swift
//  RandomUser
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

struct CacheService: CacheServiceType {
    
    typealias URLClosure = (String, FileManager) -> URL
    
    private var closure: URLClosure = { name, fileManager in
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        return folderURLs[0].appendingPathComponent(name + ".cache")
    }
    
    func saveToDisk(
        users: [User],
        withName name: String = "users",
        using fileManager: FileManager = .default
    ) throws {
        let fileURL = closure(name, fileManager)
        let data = try JSONEncoder().encode(users)
        try data.write(to: fileURL)
    }
    
    
    func loadFromDisk(
        withName name: String = "users",
        using fileManager: FileManager = .default
    ) throws -> [User] {
        let fileURL = closure(name, fileManager)
        let data = try Data(contentsOf: fileURL)
        let model = try JSONDecoder().decode([User].self, from: data)
        return model
    }
    
    
    func removeFile(withName name: String = "users",
                    using fileManager: FileManager = .default
    ) throws {
        let fileURL = closure(name, fileManager)
        try fileManager.removeItem(at: fileURL)
    }
    
    
    func isFilePersisted(
        withName name: String = "users",
        using fileManager: FileManager = .default
    ) -> Bool {
        let fileURL = closure(name, fileManager)
        return fileManager.fileExists(atPath: fileURL.path)
    }
    
}
