//
//  UIView+Extension.swift
//  TestKit
//
//  Created by steve on 2023/02/16.
//

import UIKit

fileprivate let __scale = UIScreen.main.scale

fileprivate func __pi(_ p: CGFloat) -> CGFloat {
    (round(p * __scale) / __scale)
}

extension CGRect {
    var x: CGFloat {
        get { origin.x }
        set { origin.x = __pi(newValue) }
    }
    var y: CGFloat {
        get { origin.y }
        set { origin.y = __pi(newValue) }
    }
    var w: CGFloat {
        get { size.width }
        set { size.width = __pi(newValue) }
    }
    var h: CGFloat {
        get { size.height }
        set { size.height = __pi(newValue) }
    }

    var width: CGFloat {
        get { w }
        set { w = newValue }
    }
    var height: CGFloat {
        get { h }
        set { h = newValue }
    }

    var left: CGFloat {
        get { x }
        set { x = newValue }
    }
    var right: CGFloat {
        get { x + w }
        set { x = newValue - w }
    }
    var top: CGFloat {
        get { y }
        set { y = newValue }
    }
    var bottom: CGFloat {
        get { y + h }
        set { y = newValue - h }
    }
}

extension UIView {
    var x: CGFloat {
        get { frame.x }
        set { frame.x = newValue }
    }
    var y: CGFloat {
        get { frame.y }
        set { frame.y = newValue }
    }
    var w: CGFloat {
        get { frame.w }
        set { frame.w = newValue }
    }
    var h: CGFloat {
        get { frame.h }
        set { frame.h = newValue }
    }

    var width: CGFloat {
        set { frame.w = newValue }
        get { frame.w }
    }
    var height: CGFloat {
        set { frame.h = newValue }
        get { frame.h }
    }

    var left: CGFloat {
        set { frame.left = newValue }
        get { frame.left }
    }
    var right: CGFloat {
        set { frame.right = newValue }
        get { frame.right }
    }
    var top: CGFloat {
        set { frame.top = newValue }
        get { frame.top }
    }
    var bottom: CGFloat {
        set { frame.bottom = newValue }
        get { frame.bottom }
    }
}

extension UIView.AutoresizingMask {

    private static let _MASK:(UInt) -> UIView.AutoresizingMask = { UIView.AutoresizingMask(rawValue:$0) }

    static let All     = _MASK(0x12)
    static let Center  = _MASK(0x2d)
    static let Popup   = _MASK(0x2d)
    static let Full    = _MASK(0x3f)

    static let None    = _MASK(0)
    static let Left    = _MASK(0x14)
    static let Right   = _MASK(0x11)
    static let Top     = _MASK(0x22)
    static let Bottom  = _MASK(0x0a)
    static let Middle  = _MASK(0x2a)

    static let LeftTop = _MASK(0x24)
}
