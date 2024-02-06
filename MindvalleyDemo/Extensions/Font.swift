//
//  Font.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import SwiftUI

extension Font {
    static func circular(_ style: UIFont.TextStyle) -> Font {
        return Font.custom("CircularStd-Book", size: UIFont.preferredFont(forTextStyle: style).pointSize)
    }

    static func common() -> Font {
        return Font.custom("CircularStd-Book", size: 14)
    }
}
