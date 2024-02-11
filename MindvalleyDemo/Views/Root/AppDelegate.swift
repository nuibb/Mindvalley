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
    
        /// Injecting dependency for defining data provider based on Schema...
        /// Mock data for local and API response for DEV/QA/DEMO/PROD environment.
        @ObservedObject var viewModel = ChannelsListViewModel(
            remoteDataProvider: Config.shared.getRemoteDataProvider(),
            localDataProvider: Config.shared.getLocalDataProvider())
        
        window.rootViewController = UIHostingController(rootView: ChannelsListView(viewModel: viewModel))
        
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
