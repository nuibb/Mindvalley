//
//  Config.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

struct Config {
    static let shared = Config()
    private init() {}
    
    struct log {
        static let enabled = true
    }
    
    struct constant {
        static var applicationGroupIdentifier: String {
            guard let applicationGroupIdentifier = Bundle.main.object(forInfoDictionaryKey: "applicationGroupIdentifier") as? String else {
                fatalError("applicationGroupIdentifier should be defined")
            }
            return applicationGroupIdentifier
        }
    }
    
    static var baseUrl: String?
    
    /// Static base url for each environment
    private enum BaseUrl: String {
        case LOCAL = "localhost.com"//not define yet
        case DEV = "pastebin.com"//given
        case QA = "api-qa.pastebin.com"//not define yet
        case DEMO = "api-demo.pastebin.com"//not define yet
        case PROD = "api.pastebin.com"//not define yet
    }
    
    struct url {
        static var scheme: String { "https" }
        static var host: String {
            baseUrl ?? BaseUrl.LOCAL.rawValue
        }
        static var applicationType: String {
            return "application/json"
        }
    }
    
    /// Set the base url for the current environment on which the app is building on currently
    private func setupServerConfiguration() {
        #if LOCAL
        Config.baseUrl = BaseUrl.LOCAL.rawValue
        #elseif DEV
        Config.baseUrl = BaseUrl.DEV.rawValue
        #elseif QA
        Config.baseUrl = BaseUrl.QA.rawValue
        #elseif DEMO
        Config.baseUrl = BaseUrl.DEMO.rawValue
        #elseif PROD
        Config.baseUrl = BaseUrl.PROD.rawValue
        #endif
    }
    
    /// Remote data provider based on environment
    func getRemoteDataProvider() -> ChannelsDataProvider {
        self.setupServerConfiguration()
        
        #if LOCAL
        return MockDataProvider()
        #else
        return ApiDataProvider()
        #endif
    }
    
    /// Remote data provider based on environment
    func getLocalDataProvider() -> StorageDataProvider {
        return StorageDataProvider(context: PersistentStorage.shared.context)
    }
    
}
