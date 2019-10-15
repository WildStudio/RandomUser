//
//  JSON.swift
//  RandomUserKit
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import os

public struct JSON {
    
    public static func decodeModel<M: Decodable>(_ key: String, _ data: Data) -> M? {
        do {
            guard let json = decodedData(from: data),
                let value = json[key]
                else { return nil }
            let data = try serialize(value: value)
            let model = try JSONDecoder().decode(M.self, from: data)
            return model
        } catch let error {
            os_log("Can't decode model", log: Log.networking, type: .error, error.localizedDescription)
            return nil
        }
    }
    
    
    public static func decodeModels<M: Decodable>(_ key: String,  _ data: Data) -> [M]? {
        do {
            guard let json = decodedData(from: data),
                let value = json[key]
                else { return nil }
            print(value)
            let data = try serialize(value: value)
            let models = try JSONDecoder().decode([M].self, from: data)
            return models
        } catch let error {
            os_log("Can't decode models", log: Log.networking, type: .error, error.localizedDescription)
            return nil
        }
    }
    
    
    private static func decodedData(from data: Data) -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
    
    
    private static func serialize(value: Any) throws -> Data {
        return try JSONSerialization.data(withJSONObject: value, options: [])
    }

}

