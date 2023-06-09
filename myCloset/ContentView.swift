//
//  ContentView.swift
//  myCloset
//
//  Created by alexa on 3/03/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {

    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    @State public var newClothingItem = ""
    @State var showingAlert : Bool = false
    
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
                TextField("Clothing Item", text:$newClothingItem).multilineTextAlignment(.center)
                Button {
                    // Upload the image
                    uploadPhoto()
                    showingAlert = true
                } label: {
                    Text("Upload photo")
                }
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("Successfully uploaded clothing item to closet, tap 'Select a Photo' to upload more!"))
                }
            }
//            Divider()
//            HStack{
//                // loop through the images and display them
//                ForEach(retrievedImages, id: \.self) { image in
//                    Image(uiImage: image)
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                }
//            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil){
            // Image picker
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }
//        .onAppear {
//            retrievePhotos()
//        }
    }

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
                
                // Add a "timestamp" field with the current time
                let timestamp = Timestamp(date: Date())
                
                db.collection("images").document().setData(["url" : path, "newClothingItem": newClothingItem, "timestamp": timestamp]) { error in
                    
                    // If there were no errors, display the new image
                    
                    if error == nil {
                        
                        DispatchQueue.main.async {
                            // add the uploaded image to the list of images for display
                            self.retrievedImages.append(self.selectedImage!)
                        }
                        
                    } // end error(db.collection
                    
                } // end db.collection
                
            } // end error(uploadTask)
            
        }// end uploadTask
    }


//    func retrievePhotos() {
//        // Get the data from the database
//        let db = Firestore.firestore()
//
//        db.collection("images").getDocuments { snapshot, error in
//
//            if error == nil && snapshot != nil {
//
//                var paths = [String]()
//
//
//                for doc in snapshot!.documents {
//                    // Extract the file path and add to array
//                    paths.append(doc["url"] as! String)
//                }
//
//                // Loop through each file path and fetch the data from storage
//                for path in paths {
//                    // Get a reference to storage
//                    let storageRef = Storage.storage().reference()
//
//                    // Specify the path
//                    let fileRef = storageRef.child(path)
//
//                    // Retrieve the data
//                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//
//                        // Check for errors
//                        if error == nil && data != nil {
//                            // Create a UIImage and put it into our array for display
//                            if let image = UIImage(data: data!){
//                                DispatchQueue.main.async {
//                                    retrievedImages.append(image)
//                                }
//                            }
//                        }
//                    }
//                } // end loop through paths
//            }
//        }
//
//
//    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
