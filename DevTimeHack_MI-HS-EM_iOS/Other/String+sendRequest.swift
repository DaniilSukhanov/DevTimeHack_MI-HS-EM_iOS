//
//  String+sendRequest.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

extension String {
    @discardableResult
    @Sendable
    func sendRequest(
        typeMethod: TypeMethodRequest = .get,
        parameters: [URLQueryItem]? = nil,
        headers: [String: String]? = nil,
        body: Data? = nil
    ) async throws -> (Data, URLResponse) {
        var components = URLComponents(string: self)
        components?.queryItems = parameters
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = typeMethod.rawValue
        if let body {
            request.httpBody = body
        }
        if let headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        let (data, responce) = try await URLSession.shared.data(for: request)
        guard let statusCode = (responce as? HTTPURLResponse)?.statusCode else {
            throw URLError(.cannotParseResponse)
        }
        if statusCode != 200 {
            print(String(data: data, encoding: .utf8))
            throw URLError(.init(rawValue: statusCode))
        }
        return (data, responce)
    }
}

extension String {
    enum TypeMethodRequest: String {
        case post = "POST"
        case delete = "DELETE"
        case get = "GET"
        case put = "PUT"
    }
}
