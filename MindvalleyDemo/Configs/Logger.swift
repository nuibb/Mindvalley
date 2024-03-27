//
//  Logger.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

let isProduction = Bundle.main.isProduction

extension Optional where Wrapped == String {
    var unwrapped: String {
        return (self ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct Logger {
    enum LogType: String, CustomStringConvertible {
        case debug = "🤖"
        case success = "🟢"
        case error = "🔴"
        case warning = "🟡"
        case info = "🟣"
        
        var description: String {
            return rawValue
        }
    }
    
    static var logsFile: URL? {
        guard let documentsDirectory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Config.constant.applicationGroupIdentifier) else { return nil }
        return documentsDirectory.appendingPathComponent("logger.txt")
    }
    
    static func clearLogs() {
        guard let logFile = logsFile else {
            return
        }
        try? FileManager.default.removeItem(at: logFile)
    }
    
    static func log(type: LogType = .info, _ message: Any, file: String = #file,
                    function: String = #function, line: Int = #line, toFile: Bool = false) {
        guard Config.log.enabled && !isProduction else { return }
        
        var output = "\(type) \(Date().toString())"
        let filename = file.components(separatedBy: "/").last.unwrapped
        output += "\(filename):\(function):\(line) \(message)"
        print(output)
        if toFile {
            logToFile(output)
        }
    }
    
    static func logToFile(_ message: String) {
        guard let logFile = logsFile else {
            return
        }
        guard let data = (message + "\n").data(using: String.Encoding.utf8) else { return }
        if FileManager.default.fileExists(atPath: logFile.path) {
            if let fileHandle = try? FileHandle(forWritingTo: logFile) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        } else {
            try? data.write(to: logFile, options: .atomicWrite)
        }
    }
}

