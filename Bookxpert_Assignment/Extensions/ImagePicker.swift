//
//  ImagePicker.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//

import Foundation
import UIKit
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable{
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentataionMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // leave alone right now
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        var parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        // show selected image in profile
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                parent.selectedImage = image
                _ = ImageFileManager.saveImageToDocuments(image: image)
            }
            parent.presentataionMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}










