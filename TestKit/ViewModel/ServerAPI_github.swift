//
//  ServerAPI_itbook.swift
//  TestKit
//
//  Created by steve on 2023/02/15.
//

import Foundation
import Combine

struct Users: Codable {

    let total_count: Int
    let incomplete_results: Bool
    let items: [Item]

    struct Item: Codable, HeadProtocol {
        var Iuid: String      { "\(login)" }
        var Ititle: String    { login }
        var Isubtitle: String { type }
        var Iprice: String    { "" }
        var Ithumb: String    { avatar_url }

        let login: String
        let id:    Int
        let avatar_url: String
        let type: String
    }

    struct Info: Codable, BodyProtocol {
        var Iauthors: String   { name ?? "" }
        var Ipublisher: String { location ?? "" }
        var Ipages: String     { "" }
        var Iyear: String      { create_at ?? "" }
        var Irating: String    { "" }
        var Idesc: String      { "\(public_repos ?? 0),\(public_gists ?? 0)::\(followers ?? 0),\(following ?? 0)" }

        let login: String?
        let id:    Int?
        let name:  String?
        let location: String?
        let create_at: String?
        
        let public_repos: Int?
        let public_gists: Int?
        let followers: Int?
        let following: Int?
    }
}


// https://docs.github.com/en/search-github/searching-on-github/searching-users
class ServerAPI_github {

    let server = Server()

    init(token: String) {
        server.baseURI = "https://api.github.com/"
        server.accept  = "application/vnd.github+json"
        server.token   = token
    }

    ///https://docs.github.com/en/rest/search#search-users
    func fetchList(_ text: String, page: Int) -> AnyPublisher<[HeadProtocol], Error> {
        server.fetch(uri: "search/users",
                     params: ["q":"\(text) in:name type:user", "page": page, "per_page": 100],
                     type: Users.self)
            .compactMap { $0.items }
            .eraseToAnyPublisher()
    }

    ///https://docs.github.com/en/rest/users/users#get-a-user
    func fetchBody(_ uid: String) -> AnyPublisher<BodyProtocol, Error> {
        server.fetch(uri: "users/\(uid)", type: Users.Info.self)
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
