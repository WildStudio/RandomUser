//
//  Logs.swift
//  RandomUser
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import os

private let subsystem = "com.adevinta.RandomUser"

struct Log {
    
    static let cache = OSLog(subsystem: subsystem, category: "cache")
    
}
