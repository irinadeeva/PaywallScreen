//
//  Untitled.swift
//  PaywallScreen
//
//  Created by Irina Deeva on 05/08/25.
//

import UIKit
import Foundation

class ColorManager {
    static var white: UIColor {
        UIColor(hex: 0xFFFFFF)
    }

    static var main: UIColor {
        UIColor(hex: 0xE5FE99)
    }

    static var darkGray: UIColor {
        UIColor(hex: 0x414141)
    }

    static var gray: UIColor {
        UIColor(hex: 0xB4B4B4)
    }

    static var graysGray: UIColor {
        UIColor(hex: 0x8E8E93)
    }

    static var filling: UIColor {
        UIColor(hex: 0x280069)
    }

    static var bg: UIColor {
        UIColor(hex: 0x000000)
    }
}

extension UIColor {
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
