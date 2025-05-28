//
//  ImageFileManager.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 28/05/25.
//

import Foundation
import SwiftUI

struct ImageFileManager {
    static func saveImageToDocuments(image: UIImage, name: String = "profile.jpg") -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        do {
            try data.write(to: filename)
            return filename
        } catch {
            print("Failed to save the image:", error)
            return nil
        }
    }

    static func loadImageFromDocuments(name: String = "profile.jpg") -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(name)
        return UIImage(contentsOfFile: fileURL.path)
    }

    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
