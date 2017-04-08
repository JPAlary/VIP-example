//
//  EndpointToURLRequestTransformer.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation

struct EndpointToURLRequestTransformer: Transformer {

    // MARK: Transformer

    func transform(object: Endpoint) throws -> URLRequest {
        guard let url = URL(string: object.baseUrl)?.appendingPathComponent(object.path) else {
            throw MalformedURLAppError()
        }

        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false)

        if let queryParameter = object.queryParameters {
            urlComponent?.queryItems = queryParameter.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let finalUrl = urlComponent?.url else {
            throw MalformedURLAppError()
        }

        var request = URLRequest(url: finalUrl)
        request.httpMethod = object.httpMethod.rawValue

        object.headers?.forEach({ (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        })

        if let bodyParameter = object.bodyParameter {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameter, options: .prettyPrinted)
            } catch {
                throw SerializationAppError(error: error)
            }
        }
        
        return request
    }
}
