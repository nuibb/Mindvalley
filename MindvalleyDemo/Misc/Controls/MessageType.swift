//
//  MessageType.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation
import SwiftUI

enum MessageType: String, CustomStringConvertible {
    case success
    case error
    case warning
    case info
    
    var description: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .success:
            return Color.green
        case .error:
            return Color.red
        case .warning:
            return Color.yellow
        case .info:
            return Color.gray
        }
    }
}
