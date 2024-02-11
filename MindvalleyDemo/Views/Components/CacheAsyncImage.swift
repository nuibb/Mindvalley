//
//  CacheAsyncImage.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct CacheAsyncImage: View {
    let photoURL: String
    let size: CGSize
    
    private let scale: CGFloat = 3.0
    private let transaction = Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))

    var body: some View {
        AsyncImage(url: URL(string: photoURL), scale: scale, transaction: transaction) { phase in
            switch phase {
            case .success(let image):
                image.imageModifier(width: size.width, height: size.height)
            case .failure(_):
                Image(systemName: Constants.failedPhaseIcon).iconModifier(width: size.width, height: size.height)
            case .empty:
                Image(systemName: Constants.emptyPhaseIcon).iconModifier(width: size.width, height: size.height)
            @unknown default:
                ProgressView()
            }
        }
    }
}

@available(iOS 15.0, *)
struct CacheAsyncIcon: View {
    let photoURL: String
    let size: CGSize
    
    private let scale: CGFloat = 3.0
    private let transaction = Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))

    var body: some View {
        if let cachedUrl = URL(string: photoURL),
            cachedUrl.checkIfFileExistsWith(name: photoURL),
           let image = cachedUrl.loadImage(imageName: photoURL) {
            Image(uiImage: image).iconModifierFill(width: size.width, height: size.height)
        } else {
            AsyncImage(url: URL(string: photoURL), scale: scale, transaction: transaction) { phase in
                switch phase {
                case .success(let image):
                    image.iconModifierFill(width: size.width, height: size.height)
                case .failure(_):
                    Image(systemName: Constants.failedPhaseIcon).iconModifier(width: size.width, height: size.height)
                case .empty:
                    Image(systemName: Constants.emptyPhaseIcon).iconModifier(width: size.width, height: size.height)
                @unknown default:
                    ProgressView()
                }
            }
        }
    }
}
