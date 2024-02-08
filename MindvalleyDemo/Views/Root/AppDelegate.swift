//
//  AppDelegate.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        /// Defining server configuration domain on the current 'Schema' by the run time
        Config.shared.setupServerConfiguration()
        Logger.log(type: .info, "[Current][Environment]: \(Config.baseUrl ?? "Not Defined Yet")")
    
        /// Injecting dependency for defining data provider based on Schema...
        /// Mock data for local and API response for DEV/QA/DEMO/PROD environment.
        window.rootViewController = UIHostingController(
            rootView: ChannelsListView(
                viewModel: ChannelsListViewModel(
                    dataProvider: Config.shared.getDataProvider())))
        
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
