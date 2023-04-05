//
//  NewClothingItemView.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/26/23.
//

import SwiftUI

struct NewClothingItemView: View {
    @EnvironmentObject var clothingItemManager: ClothingItemManager
    
    @State private var newClothingItem = ""
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    @State var retrievedImages = [UIImage]()
    
    var body: some View {
        VStack {
            if selectedImage != nil{
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
            Button{
                            
                            // Show the image picker
                            isPickerShowing = true
                            
                        } label:{
                            Text("Select a Photo")
                        }
            TextField("Item Tag", text:$newClothingItem)
            
            Button {
                let path = "images/\(UUID().uuidString).jpg"
                uploadPhoto()
                clothingItemManager.addClothingItem(newItemTag: newClothingItem, newItemPhoto: path)
                
            } label : {
                Text("Save")
            }
            .sheet(isPresented: $isPickerShowing, onDismiss: nil){
                // Image picker
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
        }
        .padding()
    }
}

struct NewClothingItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewClothingItemView()
    }
}
