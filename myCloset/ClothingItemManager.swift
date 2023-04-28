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
    @State var clothingImages: [UIImage] = []
 

    

    init() {

        fetchClothingItems()

    }

    

    func fetchClothingItems() {

        clothingItems.removeAll()

        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        let ref = db.collection("images").order(by: "timestamp", descending: true)

        ref.getDocuments { snapshot, error in

            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let itemTag = data["newClothingItem"] as? String ?? ""
                    let imageURL = data["url"] as? String ?? ""
                    let fileRef = storageRef.child(imageURL)
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if error == nil && data != nil {
                            if let image = UIImage(data: data!) {
                                let clothingItem = ClothingItem(ItemTag: itemTag, ImageURL: image)
                                DispatchQueue.main.async {
                                    self.clothingImages.append(image)
                                    self.clothingItems.append(clothingItem)
                                }
                            }
                        }
                    }
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
