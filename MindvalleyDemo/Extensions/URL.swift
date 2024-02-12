//
//  URL.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import SwiftUI

extension URL {
    func getWritableFilePath(_ fileURL: URL) -> URL? {
        /// Get the documents directory URL
        guard let documentsDirectory = documentDirectoryPath() else { return nil }
        
        /// Check if the file is writable or create the necessary directories
        do {
            if FileManager.default.isWritableFile(atPath: fileURL.path) {
                return fileURL
            } else {
                try FileManager.default.createDirectory(
                    at: documentsDirectory,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
                return fileURL
            }
        } catch {
            Logger.log(type: .info, "Error creating directories: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path.first
    }
    
    func checkIfFileExistsAt(url: URL) -> Bool {
        if FileManager.default.fileExists(atPath: url.path) {
            return true
        } else {
            Logger.log(type: .error, "FILE NOT EXISTS AT PATH: \(url.path)")
            return false
        }
    }
    
    func loadImage() -> UIImage? {
        guard let documentsDirectory = documentDirectoryPath() else { return nil }
        let fileUrl = documentsDirectory.appendingPathComponent(self.lastPathComponent)
        if checkIfFileExistsAt(url: fileUrl) {
            if let data = try? Data(contentsOf: fileUrl), let loaded = UIImage(data: data) {
                return loaded
            }
        }
        return nil
    }
    
    private func saveImageLocally(_ image: UIImage) {
        guard let documentsDirectory = documentDirectoryPath() else { return }
        let fileUrl = documentsDirectory.appendingPathComponent(self.lastPathComponent)
        if let filePath = getWritableFilePath(fileUrl) {
            Logger.log(type: .info, "[WRITABLE FILE PATH]: \(filePath.path)")
            if let jpgData = image.jpegData(compressionQuality: 1.0) {
                do {
                    try jpgData.write(to: filePath, options: [.atomic])
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
        Logger.log(type: .error, "[Download successful for: \(self.lastPathComponent)")
        self.saveImageLocally(image)
    }
}
