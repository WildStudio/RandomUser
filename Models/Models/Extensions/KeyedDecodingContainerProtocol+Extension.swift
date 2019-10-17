//
//  KeyedDecodingContainerProtocol+Extension.swift
//  Models
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public extension KeyedDecodingContainerProtocol {
    
    func decodeIfPresent<T: Decodable>(key: Self.Key, else defaultValue: T) -> T {
        return (try? decodeIfPresent(T.self, forKey: key)) ?? defaultValue
    }
}
