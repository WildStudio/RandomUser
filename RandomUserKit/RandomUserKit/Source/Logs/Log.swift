//
//  Log.swift
//  RandomUserKit
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import os

private let subsystem = "com.adevinta.RandomUserKit"

struct Log {
    
    static let networking = OSLog(subsystem: subsystem, category: "networking")
    
    static let decoding = OSLog(subsystem: subsystem, category: "decoding")
    
}
