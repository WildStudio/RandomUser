//
//  ServiceType.swift
//  RandomUserKit
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

/// A type that knows how to perform requests for Random user data from http://randomuser.me/ API.

public protocol ServiceType {
    
    var serverConfig: ServerConfigType { get }
    
    init(serverConfig: ServerConfigType)
    
    func fetchUsers(completion: @escaping (_ builds: [User]?, _ error: Error?) -> ())
}

extension ServiceType {
    
    // Prepares a URL request to be sent to the server.
    ///
    /// - parameter originalRequest: The request that should be prepared.
    /// - parameter query:           Additional query params that should be attached to the request.
    /// - returns: A new URL request that is properly configured for the server.
    public func preparedRequest(
        forRequest originalRequest: URLRequest,
        query: [String: Any] = [:]
    ) -> URLRequest {
        var request = originalRequest
        guard let URL = request.url else {
            return originalRequest
        }
        
        var httpHeaders: [String: String] = [:]
        
        let method = request.httpMethod?.uppercased()
        var components = URLComponents(url: URL, resolvingAgainstBaseURL: false)!
        var queryItems = components.queryItems ?? []
        
        if method == .some("POST") || method == .some("PUT") {
            if request.httpBody == nil {
                httpHeaders["Content-Type"] = "application/json; charset=utf-8"
                request.httpBody = try? JSONSerialization.data(withJSONObject: query, options: [])
            }
        } else {
            queryItems.append(
                contentsOf: query
                    .flatMap(self.queryComponents)
                    .map(URLQueryItem.init(name:value:))
            )
        }
        components.queryItems = queryItems.sorted { $0.name < $1.name }
        request.url = components.url
        
        let currentHeaders = request.allHTTPHeaderFields ?? [:]
        request.allHTTPHeaderFields = currentHeaders.withAllValuesFrom(httpHeaders)
        
        return request
    }
    
    
    /// Prepares a request to be sent to the server.
    ///
    /// - parameter URL:    The URL to turn into a request and prepare.
    /// - parameter method: The HTTP verb to use for the request.
    /// - parameter query:  Additional query params that should be attached to the request.
    ///
    /// - returns: A new URL request that is properly configured for the server.
    public func preparedRequest(
        forURL url: URL,
        method: HTTPMethod = .GET,
        query: [String: Any] = [:]
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return self.preparedRequest(forRequest: request, query: query)
    }
    
    
    private func queryComponents(
        _ key: String,
        _ value: Any
    ) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += self.queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += self.queryComponents("\(key)[]", value)
            }
        } else {
            components.append((key, String(describing: value)))
        }
        
        return components
    }
    
}
