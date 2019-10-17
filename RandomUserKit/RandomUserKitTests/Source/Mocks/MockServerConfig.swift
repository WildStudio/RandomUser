//
//  MockServerConfig.swift
//  RandomUserKitTests
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import RandomUserKit

struct MockServerConfig: ServerConfigType {
    
    public var apiBaseUrl: URL = URL(string: "https://randomuser.me/")!
    
}
