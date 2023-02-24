//
//  Server.swift
//  TestKit
//
//  Created by steve on 2023/02/16.
//

import Foundation
import Combine

class Server {

    var baseURI = ""
    var token   = ""
    var accept  = ""// "application/vnd.github+json"

    private let decoder = JSONDecoder()

    private func toURLRequest(uri: String, params: Params?) -> URLRequest {
        let url = (baseURI + uri).toURL(params)

        print("request:\(url)")

        var request = URLRequest(url: url)
        if token.count > 0 {
            request.setValue("Bearer ghp_\(token)", forHTTPHeaderField: "Authorization")
        }

        if accept.count > 0 {
            request.setValue(accept, forHTTPHeaderField: "Accept")
        }

        return request
    }

    func fetch<T: Decodable>(uri: String, params: Params? = nil, type: T.Type) -> AnyPublisher<T, Error> {
        let request = toURLRequest(uri: uri, params: params)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: type, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
