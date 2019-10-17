//
//  ServerConfig.swift
//  RandomUserKit
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

// A type that knows the location of the Random User Generator API
public protocol ServerConfigType {
  var apiBaseUrl: URL { get }
}

public struct ServerConfig: ServerConfigType {
    
    public var apiBaseUrl: URL
    
    public init(apiBaseUrl: URL) {
       self.apiBaseUrl = apiBaseUrl
    }

}
