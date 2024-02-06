//
//  Utils.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

struct Utils {
    static func after(seconds: Double, callback:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            callback()
        }
    }
}
