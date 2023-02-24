//
//  ViewModel.swift
//  TestKit
//
//  Created by steve on 2023/02/15.
//

import Foundation
import Combine

protocol HeadProtocol {
    var Iuid: String { get }
    var Ititle: String { get }
    var Isubtitle: String { get }
    var Iprice: String { get }
    var Ithumb: String { get }
}

protocol BodyProtocol {
    var Iauthors: String { get }
    var Ipublisher: String { get }
    var Ipages: String { get }
    var Iyear: String { get }
    var Irating: String { get }
    var Idesc: String { get }
}

class Item: HeadProtocol, BodyProtocol {
    
    init(head: HeadProtocol) {
        self.head = head
    }

    var head: HeadProtocol!
    var body: BodyProtocol!

    var Iuid: String       { head.Iuid }
    var Ititle: String     { head.Ititle }
    var Isubtitle: String  { head.Isubtitle }
    var Iprice: String     { head.Iprice }
    var Ithumb: String     { head.Ithumb }

    var Iauthors: String   { body.Iauthors }
    var Ipublisher: String { body.Ipublisher }
    var Ipages: String     { body.Ipages }
    var Iyear: String      { body.Iyear }
    var Irating: String    { body.Irating }
    var Idesc: String      { body.Idesc }
}

class ViewModel {

    private let server = ServerAPI_itbook(token: "")
    private var bags   = Set<AnyCancellable>()

    @Published var list = [Item]()
    @Published var body: Item!

    private var searchText = ""
    private var searchPage = 1
    
    private func searchList() {
        server.fetchList(searchText, page: searchPage)
            .sink { _ in
            } receiveValue: {
                let list = $0.map { Item(head:$0) }
                if list.count < 10 { self.searchPage = 0 }

                self.list += list
            }
            .store(in: &bags)
    }
    
    func searchText(_ text: String) {
        if list.count > 0 { list.removeAll() }

        searchText = text
        searchPage = 1
        searchList()
    }
    
    func searchNext() {
        if searchPage == 0 { return }

        searchPage += 1
        searchList()
    }

    func requestBody(_ item: Item) {
        if item.body != nil {
            body = item
            return
        }

        server.fetchBody(item.Iuid)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.body = nil
                    print("Failure error:", error.localizedDescription)
                default:
                    break
                }
            } receiveValue: {
                item.body = $0
                self.body = item
            }
            .store(in: &bags)
    }
}
