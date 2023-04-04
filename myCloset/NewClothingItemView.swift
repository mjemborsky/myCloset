//
//  NewClothingItemView.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/26/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore


struct NewClothingItemView: View {
    @EnvironmentObject var clothingItemManager: ClothingItemManager
    @State private var newClothingItem = ""
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
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
            
            // Upload button
            if selectedImage != nil{
                Button {
                    // Upload the image
                    uploadPhoto()
                    
                } label: {
                    Text("Upload photo")
                }
                Divider()
                TextField("ItemTag", text: $newClothingItem)
            }
            
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil){
            // Image picker
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }
        
    }

    
    // content view
    
    func uploadPhoto(){
        
        
        // Make sure that the selected image property isn't nil
        guard selectedImage != nil else {
            return
        }
        
        // Create storage reference
        let storageRef =  Storage.storage().reference()
        
        // Turn our image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        // Specify the file path and name
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            // Check for errors
            
            if error == nil && metadata != nil {
                // Save a reference to the file in Firestore DB
                let db = Firestore.firestore()
                db.collection("images").document().setData(["ItemTag" : $newClothingItem, "url" : path]){ error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    // If there were no errors, display the new image
//                    if error == nil {
//
//                        DispatchQueue.main.async {
//                            // add the uploaded image to the list of images for display
//                            self.retrievedImages.append(self.selectedImage!)
//                        }
                        
                    } // end error(db.collection
                } // end db.collection
            } // end error(uploadTask)
        } // end uploadTask
    } // end UploadPhoto
    
    struct NewClothingItemView_Previews: PreviewProvider {
        static var previews: some View {
            NewClothingItemView()
        }
    }
//end
