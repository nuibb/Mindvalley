//
//  MindvalleyDemoAppWrapper.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import SwiftUI

@main
struct MindvalleyDemoAppWrapper {
    /// To support iOS 13, using UIKit based AppDelegate for launching application, otherwise using SwiftUI View as root view
    static func main() {
        if #available(iOS 14.0, *) {
            MindvalleyDemoApp.main()
        } else {
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(AppDelegate.self))
        }
    }
}
