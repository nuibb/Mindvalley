//
//  ChannelsListViewModel.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation
import SwiftUI

final class ChannelsListViewModel: ObservableObject {
    @Published var messageColor: Color = MessageType.error.color
    @Published var isRequesting: Bool = false
    @Published var showToast: Bool = false
    
    let dataProvider: ChannelsDataProvider
    var toastMessage: String = ""

    init(dataProvider: ChannelsDataProvider) {
        self.dataProvider = dataProvider
        Utils.after(seconds: 1) {
            self.fetchNewEpisodes()
        }
    }
    
    func fetchNewEpisodes() {
        self.isRequesting = true
        
        Task { [weak self] in
            guard let self = self else { return }
            let response = await dataProvider.fetchNewEpisodes()
            if case .success(let data) = response {
                Logger.log(type: .error, "[Response][Data]: \(data)")
                DispatchQueue.main.async {
                    self.isRequesting = false
                }
            } else if case .failure(let error) = response {
                Logger.log(type: .error, "[Request] failed: \(error.description)")
                DispatchQueue.main.async {
                    self.isRequesting = false
                    self.displayMessage(error.description)
                }
            } else {
                DispatchQueue.main.async {
                    self.isRequesting = false
                    self.displayMessage(RequestError.unknown.description)
                }
            }
        }
    }
    
    private func displayMessage(_ msg: String) {
        toastMessage = msg
        showToast = true
        Utils.after(seconds: 5.0) {
            self.toastMessage = ""
        }
    }
    
}
