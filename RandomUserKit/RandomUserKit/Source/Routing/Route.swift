//
//  Route.swift
//  RandomUserKit
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

enum Route {
    case users(results: Int?)
    
    enum UploadParam: String {
        case image
        case video
    }
    
    var requestProperties:
        (method: HTTPMethod, path: String, query: [String: Any], file: (name: UploadParam, url: URL)?) {
        switch self {
        case let .users(results):
            var params: [String: Any] = [:]
            params["results"] = results
            return (.GET, "/api", params, nil)
        }
    }
}
