//
//  CacheAsyncImage.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct CustomAsyncImage: View {
    let photoURL: String
    let size: CGSize
    let isIcon: Bool
    
    init(photoURL: String, size: CGSize, isIcon: Bool) {
        self.photoURL = photoURL
        self.size = size
        self.isIcon = isIcon
    }
    
    var body: some View {
        CacheAsyncImage(photoURL: photoURL, size: size, isIcon: isIcon) { phase in
            switch phase {
            case .success(let image):
                if !isIcon {
                    image.imageModifier(size: size)
                } else {
                    image.iconModifierFill(size: size)
                }
            case .failure(_):
                Image(systemName: Constants.failedPhaseIcon).iconModifier(size: size)
            case .empty:
                Image(systemName: Constants.emptyPhaseIcon).iconModifier(size: size)
            @unknown default:
                ProgressView()
            }
        }
    }
}

@available(iOS 15.0, *)
struct CacheAsyncImage<Content>: View where Content: View {
    let photoURL: String
    let size: CGSize
    let isIcon: Bool
    let content: (AsyncImagePhase) -> Content
    
    private let scale: CGFloat = 3.0
    private let transaction = Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))
    
    init(photoURL: String, size: CGSize, isIcon: Bool, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.photoURL = photoURL
        self.size = size
        self.isIcon = isIcon
        self.content = content
    }
    
    var body: some View {
        AsyncImage(url: URL(string: photoURL), scale: scale, transaction: transaction) { phase in
            cacheAndRender(phase: phase)
        }
    }
    
    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(_) = phase {
            if let imageURL = URL(string: photoURL) {
                Task {
                    do {
                        /// Download and cache Image locally as `UIImage`
                        try await imageURL.downloadImage()
                    } catch {
                        Logger.log(type: .error, "Image download failed with error: \(error)")
                    }
                }
            }
        }
        return content(phase)
    }
}
