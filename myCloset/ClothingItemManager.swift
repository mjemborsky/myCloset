//
//  ClothingItemManager.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/26/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class ClothingItemManager: ObservableObject {
    @Published var clothingItems: [ClothingItem] = []
    
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
    func addClothingItem(newItemTag: String, newItemPhoto: String){
        let path = "images/\(UUID().uuidString).jpg"
        let db = Firestore.firestore()
        let ref = db.collection("ClothingItems").document(newItemTag)
        ref.setData(["id": 10, "ItemTag": newItemTag, "ItemPhoto": path]) {error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
