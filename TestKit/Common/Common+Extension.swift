//
//  Common+Extension.swift
//  TestKit
//
//  Created by steve on 2023/02/16.
//

import Foundation

public typealias Params = [String: Any]

extension Params {
    func toQuery() -> String {
        map { "\($0)=\($1)" }
        .joined(separator: "&")
        .asURLQuery
    }
}

extension Int {
    
    var asFloat: CGFloat { CGFloat(self) }
}

extension Array where Element: Equatable {

    mutating func remove(_ obj: Element) {
        guard let index = firstIndex(of:obj) else { return }
        remove(at:index)
    }

    mutating func remove(array:Array) {
        if array.count == 0 { return }
        self = filter { !array.contains($0) }
    }
}
