//
//  Service.swift
//  RandomUserKit
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models
import os

public struct Service: ServiceType {
    
    private enum Keys {
        static let results = "results"
    }
    
    public let serverConfig: ServerConfigType
    
    
    public init(serverConfig: ServerConfigType) {
        self.serverConfig = serverConfig
    }
    
    
    public func fetchUsers(results: Int? = nil, completion: @escaping ([User]?, Error?) -> ()) {
        request(.users(results: results)) { result in
            switch result {
            case .success(let data):
                guard let users = self.decodeModels(Keys.results, data) as [User]?
                    else { return }
                DispatchQueue.main.async {
                    completion(users, nil)
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async { completion(nil, error) }
            }
        }
    }
    
}

extension Service {
    
    private static let session = URLSession(configuration: .default)
    
    
    private func request(
        _ route: Route,
        completion: @escaping (Result<Data, Error>) -> ()
    ) {
        let properties = route.requestProperties
        
        guard let URL = URL(
            string: properties.path, relativeTo: serverConfig.apiBaseUrl) else {
                fatalError(
                    "URL(string: \(properties.path), relativeToURL: \(String(describing: serverConfig.apiBaseUrl))) == nil"
                )
        }
        
        let request = preparedRequest(
            forURL: URL,
            method: properties.method,
            query: properties.query
        )
        
        Service.session.dataResponse(request, completion: completion)
    }
    
    
    private func decodeModel<M: Decodable>(_ key: String, _ data: Data) -> M? {
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
    
    
    private func decodeModels<M: Decodable>(_ key: String,  _ data: Data) -> [M]? {
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
    
    
    private func decodedData(from data: Data) -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
    
    
    private func serialize(value: Any) throws -> Data {
        return try JSONSerialization.data(withJSONObject: value, options: [])
    }
    
}
