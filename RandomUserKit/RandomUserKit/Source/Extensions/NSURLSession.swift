//
//  NSURLSession.swift
//  RandomUserKit
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

typealias NetworkResponse = (data: Data, response: URLResponse)
typealias NetworkResponseResultCompletion = (Result<Data, Error>) -> Void


extension URLSession {
    
    func dataResponse(
        _ request: URLRequest,
        uploading file: (url: URL, name: String)? = nil,
        completion: @escaping NetworkResponseResultCompletion
    ) {
        print(request)
        dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let strongSelf = self, let response = response, let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            
            strongSelf.validateNetworkResponse((data, response)) { (validationResult) in
                switch validationResult {
                case .success:
                    print(response)
                    completion(.success((data)))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    private func validateNetworkResponse(
        _ networkResponse: NetworkResponse,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let response = networkResponse.response as! HTTPURLResponse
        switch response.statusCode {
        case 200...299:
            completion(.success(()))
        case 400...500:
            let error = decodeError(data: networkResponse.data)
            completion(.failure(error))
        case 501...599:
            completion(.failure(NetworkError.badRequest))
        default:
            completion(.failure(NetworkError.unknown))
        }
    }
    
    private func decodeError(data: Data) -> Error {
        do {
            let server = try JSONDecoder().decode(ErrorContainer.self,
                                                  from: data)
            guard let error = server.errors.first else {
                return NetworkError.badContent
            }
            return NetworkError(rawValue: error.code) ?? NetworkError.unknown
        } catch {
            return error
        }
    }
    
}

enum NetworkError: String, Error {
    case badRequest
    case unknown
    case badContent
}

struct ErrorContainer: Codable {
    let errors: [ErrorResponse]
}

// MARK: - Error
struct ErrorResponse: Codable {
    let status: String?
    let code: String
    let id: String?
    let detail: String?
    let message: String?
}
