//
//  ClothingItemManager.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/26/23.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ClothingItemManager: ObservableObject {

    @Published var clothingItems: [ClothingItem] = []
 

    

    init() {

        fetchClothingItems()

    }

    

    func fetchClothingItems() {

        clothingItems.removeAll()

        let db = Firestore.firestore()

        let ref = db.collection("images")

        ref.getDocuments { snapshot, error in

            guard error == nil else {

                print(error!.localizedDescription)

                return

            }

            

            if let snapshot = snapshot {

                for document in snapshot.documents {

                    let data = document.data()

                    

                    let ItemTag = data["newClothingItem"] as? String ?? ""

                    let ImageURL = data["url"] as? String ?? ""

                    

                    let clothingItem = ClothingItem(ItemTag: ItemTag, ImageURL: ImageURL)

                    self.clothingItems.append(clothingItem)

                }

            }

        }

    }

    func addClothingItem(newItemTag: String, newItemPhoto: String){

        let clothingPath = UUID().uuidString

        let imagePath = "images/\(UUID().uuidString).jpg"

        let db = Firestore.firestore()

        let ref = db.collection("ClothingItems").document(clothingPath)

        ref.setData(["id": 10, "ItemTag": newItemTag, "ItemPhoto": imagePath]) {error in

            if let error = error {

                print(error.localizedDescription)

            }

        }

    }

}
