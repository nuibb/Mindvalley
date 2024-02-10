//
//  URL.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import SwiftUI

extension URL {
    private func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path.first
    }
    
    func checkIfFileExistsWith(name: String) -> Bool {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(name).appendingPathExtension("jpg")
            if FileManager.default.fileExists(atPath: fileUrl.path) {
                return true
            } else {
                return false
            }
        } catch {
            Logger.log(type: .error, "[FILE][EXISTS][CHECKING] failed: \(error.localizedDescription)")
            return false
        }
    }
    
    func loadImage(imageName: String) -> UIImage? {
        if checkIfFileExistsWith(name: imageName) {
            let imageUrl = documentDirectoryPath()?.appendingPathComponent(imageName).appendingPathExtension("jpg")
            if let url = imageUrl, let data = try? Data(contentsOf: url), let loaded = UIImage(data: data) {
                return loaded
            }
        }
        return nil
    }
    
    func saveImage(_ image: UIImage, name: String) {
        if !checkIfFileExistsWith(name: name) {
            if let jpgData = image.jpegData(compressionQuality: 1.0),
               let path = documentDirectoryPath()?.appendingPathComponent(name).appendingPathExtension("jpg") {
                Logger.log(type: .info, "[PATH]: \(path)")
                do {
                    try jpgData.write(to: path)
                } catch let error {
                    Logger.log(type: .error, "[SAVE][IMAGE] failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func downloadImage() async throws -> UIImage {
        let imageRequest = URLRequest(url: self)
        let (data, imageResponse) = try await URLSession.shared.data(for: imageRequest)
        guard let image = UIImage(data: data), (imageResponse as? HTTPURLResponse)?.statusCode == 200 else {
            throw ImageDownloadError.badImage
        }
        Logger.log(type: .error, "[SAVE][IMAGE] Name: \(self.lastPathComponent)")
        saveImage(image, name: self.lastPathComponent)
        return image
    }
}
