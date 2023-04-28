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

extension UIImage {
    func crop(to rect: CGRect) -> UIImage {
        guard let cgImage = cgImage?.cropping(to: rect) else {
            return self
        }
        return UIImage(cgImage: cgImage)
    }
}

struct saveOutfitView: View {
    @State var title: String = ""
    @State var titles: [String] = []
    @State var tag: String = ""
    @State var tags: [String] = []
    @State private var showFeedView = false
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    let outfitid = UUID().uuidString
    @State private var backtocloset = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                SelectedItemsView()
                    .navigationTitle("Save Post")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                saveOutfit()
                                screenshotSelectedItemsView(captureRect: CGRect(x: 0, y: 550, width: 1500, height: 100))
                            }) {
                                Text("Save")
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                backtocloset = true
                            }) {
                                Text("Cancel")
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $backtocloset) {
                        ClosetView()
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
                    createPost(postCreator: "username", postDescription: "My favorite outfit", postTags: ["trendy", "purple", "sweater"], postImage: "", linkedOutfit: outfitid)
                    screenshotSelectedItemsView(captureRect: CGRect(x: 0, y: 550, width: 1500, height: 1000))
                    self.showFeedView = true
                }, label: {
                    Text("Post").padding()
                })
            }
        }
        .fullScreenCover(isPresented: $showFeedView) {
            FeedView()
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

        guard let imageData = croppedScreenshot.pngData() else { return }

        let imageName = UUID().uuidString + ".png"
        let imageRef = storage.child("Screenshotted selected outfits/\(imageName)")

        let metadata = StorageMetadata()
        metadata.contentType = "image/png"

        _ = imageRef.putData(imageData, metadata: metadata) { metadata, error in
            guard metadata != nil else {
                print("Error uploading image: \(error!)")
                return
            }
            print("Image uploaded successfully!")
        }
    }
    
    
}

struct saveOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        saveOutfitView()
    }
}
