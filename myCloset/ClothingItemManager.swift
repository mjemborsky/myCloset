//
//  ClothingItemManager.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/26/23.
//

import SwiftUI
import Firebase
import Foundation
import UIKit

class ClothingItemManager: ObservableObject {
    @Published var clothingItems: [ClothingItem] = []
    @State private var newClothingItem = ""
    
    init() {
        fetchClothingItems()
    }
    
    func fetchClothingItems() {
        clothingItems.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("ClothingItems")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let ItemTag = data["ItemTag"] as? String ?? ""
                    let ItemPhoto = data["ItemPhoto"] as? String ?? ""
                    
                    let clothingItem = ClothingItem(id: id, ItemTag: ItemTag, ItemPhoto: ItemPhoto)
                    self.clothingItems.append(clothingItem)
                }
            }
        }
    }
    let path = "images/\(UUID().uuidString).jpg"
    func addClothingItem(newItemPhoto: String){
        let db = Firestore.firestore()
        let ref = db.collection("images").document(newItemPhoto)
        ref.setData(["ItemTag": $newClothingItem, "URL": path]) {error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

// image picker code

//struct ImagePickers: UIViewControllerRepresentable{
//    
//    @Binding var selectedImage: UIImage?
//    @Binding var isPickerShowing: Bool
//    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let imagePickers = UIImagePickerController()
//        imagePickers.sourceType = .photoLibrary
//        imagePickers.delegate = context.coordinator // object that can recieve UIImagePickerController events
//        
//        return imagePickers
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        
//    }
//    
//    func makeCoordinator() -> Coordinators {
//        return Coordinators(self)
//    }
//}
//
//class Coordinators: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    var parent: ImagePickers
//    
//    init(_ picker: ImagePickers){
//        self.parent = picker
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        // run code when the user has selected an image
//        print("image selected")
//        
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            // we were able to get the image
//            DispatchQueue.main.async {
//                self.parent.selectedImage = image
//            }
//        }
//        // Dismiss the picker
//        parent.isPickerShowing = false
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // run code when the user has cancelled the picker UI
//        print("cancelled")
//        parent.isPickerShowing = false
//    }
//}
