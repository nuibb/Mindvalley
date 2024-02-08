//
//  CacheAsyncImage.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct ImageLoaderView: View {
    let url: String
    let url1: String = "https://images.unsplash.com/photo-1451187580459-43490279c0fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzQwMDN8MHwxfGFsbHwzM3x8fHx8fDF8fDE3MDczNjAzMTF8&ixlib=rb-4.0.3&q=80&w=200"
    
    private let scale: CGFloat = 1.0
    private let transaction = Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))
    private let size: CGSize = CGSize(width: 152, height: 228)
    
    var body: some View {
        AsyncImage(url: URL(string: url1)) { phase in
           // renderImage(phase: phase)
        }
        .frame(width: 200, height: 200)
    }
    
//    private func renderImage(phase: AsyncImagePhase) -> some View {
//        Group {
//            if let image = phase.image {
//                image
//            } else if phase.error != nil {
//                Image(systemName: Constants.failedPhaseIcon).iconModifier()
//            } else {
//                Image(systemName: Constants.emptyPhaseIcon).iconModifier()
//            }
//        }
//    }
}
