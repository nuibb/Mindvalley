//
//  Color.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}

extension Color {
    static let primaryColor = Color(hex: "FFFFFF")
    static let textLightGrey = Color(hex: "C1C1C1")
    static let textDarkGrey = Color(hex: "95989D")
    static let dividerColor = Color(hex: "3C434E")
    static let backgroundColor = Color(hex: "23272F")
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff, alpha: 1.0)
    }
}

extension UIColor {
    static let textLightGrey = UIColor(hex: "C1C1C1")
    static let backgroundColor = UIColor(hex: "23272F")
}
