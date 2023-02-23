//
//  ServerAPI_itbook.swift
//  TestKit
//
//  Created by steve on 2023/02/15.
//

import Foundation
import Combine

// MARK: - BookList
struct BookList: Codable {
    let total, page: String
    let books: [BookHead]
}

// MARK: - BookHead
struct BookHead: Codable, HeadProtocol {
    var Iuid: String      { isbn13 }
    var Ititle: String    { title }
    var Isubtitle: String { subtitle }
    var Iprice: String    { price }
    var Ithumb: String    { image }

    let title, subtitle, isbn13, price: String
    let image: String
    let url: String
}

// MARK: - BookBody
struct BookBody: Codable, BodyProtocol {

    var Iauthors: String   { authors }
    var Ipublisher: String { publisher }
    var Ipages: String     { pages }
    var Iyear: String      { year }
    var Irating: String    { rating }
    var Idesc: String      { desc }

    let error: String
    let title, subtitle, price: String

    let authors, publisher, pages: String
    let year, rating, desc: String

    let isbn10, isbn13: String
    let image: String
    let url: String
    let pdf: [String: String]?
}

class ServerAPI_itbook {

    let server = Server()

    init(token: String) {
        server.baseURI = "https://api.itbook.store/1.0/"
        server.token   = token
    }

    func fetchList(_ text: String, page: Int) -> AnyPublisher<[HeadProtocol], Error> {
        server.fetch(uri: "search/\(text)/\(page)".asURLQuery, type: BookList.self)
            .compactMap { $0.books }
            .eraseToAnyPublisher()
    }

    func fetchBody(_ uid: String) -> AnyPublisher<BodyProtocol, Error> {
        server.fetch(uri: "books/\(uid)", type: BookBody.self)
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
