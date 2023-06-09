//
//  saveOutfitView.swift
//  myCloset
//
//  Created by Taylor  on 3/26/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import Photos

extension UIImage {
    func crop(to rect: CGRect) -> UIImage {
        guard let cgImage = cgImage?.cropping(to: rect) else {
            return self
        }
        return UIImage(cgImage: cgImage)
    }
}

struct saveOutfitView: View {
    var userEmail: String
    var allUsers: [UserProfile]
    var allPosts: [Post]
    @State private var createdImageString = [String]()
    @State var title: String = ""
    @State var titles: [String] = []
    @State var tag: String = ""
    @State var tags: [String] = []
    @State private var showFeedView = false
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    let outfitid = UUID().uuidString
    @State private var backtocloset = false
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                SelectedItemsView()
                    .navigationTitle("Save Post")
                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(action: {
//                                saveOutfit()
////                                screenshotSelectedItemsView(captureRect: CGRect(x: 0, y: 550, width: 1500, height: 1000))
//                            }) {
//                                Text("Save")
//                            }
//                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                backtocloset = true
                            }) {
                                Text("Cancel")
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $backtocloset) {
                        ClosetView(userEmail: userEmail, users: allUsers, posts: allPosts)
                    }
                Spacer()
                TextField("Enter Outfit Title", text: $title)
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                TextField("Enter one or more Outfit Tags", text: $tag)
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                Button(action: {
                    screenshotSelectedItemsView(captureRect: CGRect(x: 0, y: 550, width: 1500, height: 1000))
                    if let index = allUsers.firstIndex(where: {$0.email == userEmail}) {
                        createPost(postCreator: allUsers[index].username, postDescription: title, postTags: tags, postImage: createdImageString[0])
                    }
                    showingAlert = true
//                    self.showFeedView = true
                }, label: {
                    Text("Post").padding()
                })
            }
            .alert("fabulous choice! your outfit is now visible on the home feed and in your camera roll!", isPresented: $showingAlert) {
                Button("stay", action: {})
                Button("go to feed", action: {
                    self.showFeedView = true
                })
            }
        }
        .fullScreenCover(isPresented: $showFeedView) {
            FeedView(userEmail: userEmail)
        }
    }
    
    func saveOutfit() {
        db.collection("Saved Collages").document(outfitid).setData([
            "title": title,
            "tag": tag
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // Capture the selected items view
        let captureRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
        screenshotSelectedItemsView(captureRect: captureRect)
    }
    
    func screenshotSelectedItemsView(captureRect: CGRect) {
        guard let window = UIApplication.shared.windows.first else { return }

        let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
        let screenshot = renderer.image { _ in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }

        let croppedScreenshot = screenshot.crop(to: captureRect)

        guard let imageData = croppedScreenshot.jpegData(compressionQuality: 0.9) else { return }

        let imageName = UUID().uuidString + ".jpg"
        let imageRef = storage.child("images/\(imageName)")
        createdImageString.append("images/\(imageName)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        _ = imageRef.putData(imageData, metadata: metadata) { metadata, error in
            guard metadata != nil else {
                print("Error uploading image: \(error!)")
                return
            }
            
            print("Image uploaded successfully!")
            
            // Save the image to camera roll
            UIImageWriteToSavedPhotosAlbum(croppedScreenshot, nil, nil, nil)
        }
    }
    
    
}

