//
//  Bundle.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

extension Bundle {
    var isProduction: Bool {
        #if DEBUG
            return false
        #else
        guard let path = self.appStoreReceiptURL?.path else {
            return true
        }
        return !path.contains("sandboxReceipt")
        #endif
    }
    
    func decode<T: Decodable>(_ file: String, fileExtension: String) -> Swift.Result<T, RequestError> {
        guard let url = self.url(forResource: file, withExtension: fileExtension) else {
            return .failure(.custom("Failed to locate \(file) in bundle."))
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return .failure(.custom("Failed to load \(file) from bundle."))
        }
        
        let decoder = JSONDecoder()
        guard let decodedResponse = try? decoder.decode(T.self, from: data) else {
            return .failure(.decode)
        }
        
        return .success(decodedResponse)
    }
}
