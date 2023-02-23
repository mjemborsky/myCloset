//
//  ImagePicker.swift
//  myCloset
//
//  Created by alexa on 2/22/23.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing = Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType  = .photoLibrary
        imagePicker.delegate = context.coordinator // object that can recieve UIImagePickerController events
        
        return imagePicker
    
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker){
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Run the code when the user has selected an image
        print("image selected")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            // We are able to get the image
            DispatchQueue.main.async{
                self.parent.selectedImage = image
            }
        }
        //Dismiss the picker
        parent.isPickerShowing = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Run code when the user has cancelled the UI
        print("image cancelled")
        
        //Dismiss the picker
        parent.isPickerShowing = false
    }
}
