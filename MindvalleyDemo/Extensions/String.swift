//
//  String.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

extension Optional where Wrapped == String {
    var unwrapped: String {
        return (self ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension String {
    func toDateFromTimezone() -> Date {
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withTimeZone, .withFullDate, .withFullTime, .withFractionalSeconds]
        if let date = iso.date(from: self) {
            return date
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: self) {
            return date
        }

        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss'Z'"
        if let date = formatter.date(from: self) {
            return date
        }

        // APi will give different string date, so need to test both parsing
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = formatter.date(from: self) {
            return date
        }

        // APi will give different string date, so need to test both parsing
        formatter.dateFormat = "YYYY-MM-dd"
        if let date = formatter.date(from: self) {
            return date
        }

        return Date()
    }
}
