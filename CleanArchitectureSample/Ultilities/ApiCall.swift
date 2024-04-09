//
//  ApiCall.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 08/04/2024.
//

import Foundation
import Alamofire

protocol APICall {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    func body() throws -> Parameters?
}

enum APIError: Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case dataDeserialization
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .dataDeserialization: return "Cannot deserialize data"
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> DataRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        do {
            print("url: \(url)")
            let request = AF.request(url, method: method, parameters: try body(), encoding: JSONEncoding.default, headers: headers)
            return request
        } catch {
            throw error
        }
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
