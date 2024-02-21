//
//  URL.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import SwiftUI

extension URL {
    func getWritableFilePath(_ fileURL: URL) -> URL? {
        /// Check if the file is writable or create the necessary directories
        do {
            if FileManager.default.isWritableFile(atPath: fileURL.path) {
                return fileURL
            } else {
                try FileManager.default.createDirectory(
                    at: fileURL,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
                return fileURL
            }
        } catch {
            Logger.log(type: .info, "[Creating][Directory] failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path.first
    }
}

// MARK: Image downloading and caching
extension URL {
    func loadImage() -> UIImage? {
        guard let documentsDirectory = documentDirectoryPath() else { return nil }
        let url = documentsDirectory.appendingPathComponent(Constants.projectName).appendingPathComponent(self.lastPathComponent)
        if FileManager.default.fileExists(atPath: url.path) && FileManager.default.isReadableFile(atPath: url.path)  {
            if let data = try? Data(contentsOf: url), let loaded = UIImage(data: data) {
                return loaded
            }
        } else {
            Logger.log(type: .error, "FILE NOT EXISTS OR DOESN'T HAVE READ PERMISSION AT: \(url.path)")
        }
        return nil
    }
    
    private func saveImageLocally(_ image: UIImage) {
        guard let documentsDirectory = documentDirectoryPath() else { return }
        let fileUrl = documentsDirectory.appendingPathComponent(Constants.projectName)
        if let filePath = getWritableFilePath(fileUrl) {
            if let jpgData = image.jpegData(compressionQuality: 1.0) {
                do {
                    try jpgData.write(to: filePath.appendingPathComponent(self.lastPathComponent), options: [.completeFileProtection, .atomic])
                } catch let error {
                    Logger.log(type: .error, "[SAVE][IMAGE] failed: \(error.localizedDescription)")
                }
            } else {
                Logger.log(type: .error, "JPG conversion failed!")
            }
        }
    }
    
    func downloadImage() async throws {
        let imageRequest = URLRequest(url: self)
        let (data, imageResponse) = try await URLSession.shared.data(for: imageRequest)
        guard let image = UIImage(data: data), (imageResponse as? HTTPURLResponse)?.statusCode == 200 else {
            throw ImageDownloadError.badImage
        }
        Logger.log(type: .info, "[Download successful for: \(self.lastPathComponent)")
        self.saveImageLocally(image)
    }
}
