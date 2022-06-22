//
//  NetworkManager.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 21/06/2022.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    private init() { }
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder

    func loadURLAndDecode<D: Decodable>(url: URL, params: [String:String]? = nil) async throws -> D {

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw APIRequestError.invalidEndpoint
        }

        var queryItems = [URLQueryItem]()
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }

        urlComponents.queryItems = queryItems

        guard let finalURL = urlComponents.url else {
            throw APIRequestError.invalidEndpoint
        }
        print("Final URL: \(finalURL)")
        let (data, response) = try await urlSession.data(from: finalURL)

        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw APIRequestError.invalidResponse
        }

        return try self.jsonDecoder.decode(D.self, from: data)
    }
}

