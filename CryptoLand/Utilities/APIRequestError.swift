//
//  APIRequestError.swift
//  iHaveNothingToWatch
//
//  Created by Tomasz Ogrodowski on 21/06/2022.
//

import Foundation

enum APIRequestError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data."
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }

    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey : localizedDescription]
    }
}
