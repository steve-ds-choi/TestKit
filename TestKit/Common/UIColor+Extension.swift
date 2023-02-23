//
//  UIColor+Extension.swift
//  TestKit
//
//  Created by steve on 2023/02/17.
//

import UIKit

extension UIColor {

    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }

    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        rgba(r, g, b, 1)
    }

    static func random(_ a: CGFloat = 1) -> UIColor {
        let c = Int.random(in: 0...Int.max)

        let r = (c >> 24) & 0xFF
        let g = (c >> 16) & 0xFF
        let b = (c >>  8) & 0xFF

        return rgba(CGFloat(r), CGFloat(g), CGFloat(b), a)
    }
}
