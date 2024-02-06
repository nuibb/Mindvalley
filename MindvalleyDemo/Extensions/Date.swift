//
//  Date.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

extension Date {
    func toString(_ format: String = "yyyy-dd-MM HH:mm:ss.SSS") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter.string(from: self)
    }
}
