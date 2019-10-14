//
//  Dictionary+allValues.swift
//  RandomUserKit
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func withAllValuesFrom(_ other: Dictionary) -> Dictionary {
        return self.merging(other) { $1 }
    }
}
