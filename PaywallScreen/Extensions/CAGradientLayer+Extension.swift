//
//  CAGradientLayer+Extension.swift
//  PaywallScreen
//
//  Created by Irina Deeva on 05/08/25.
//

import UIKit

extension CAGradientLayer {
    static func gradientLayer(for colours: [CGColor], in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colours
        layer.frame = frame
        return layer
    }
}
