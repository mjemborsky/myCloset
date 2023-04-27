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

struct saveOutfitView: View {
    @State var title: String = ""
    @State var titles: [String] = []
    @State var tag: String = ""
    @State var tags: [String] = []
    @State private var showFeedView = false
    let db = Firestore.firestore()
    let outfitid = UUID().uuidString
    @State private var selectedRect: CGRect?
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                SelectedItemsView()
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    selectedRect = CGRect(x: 0, y: 100, width: 400, height: 500)
                                }
                        }
                    )
                    .navigationTitle("Save Post")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                saveoutfit()
                            }) {
                                Text("Save")
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink(destination: ClosetView()) {
                                Text("Back")
                            }
                        }
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
                    if let selectedRect = selectedRect {
                        let image = takeScreenshot(rect: selectedRect)
                        uploadScreenshot(image)
                    }
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
    
    func takeScreenshot(rect: CGRect) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        let renderer = UIGraphicsImageRenderer(bounds: rect, format: format)
        let image = renderer.image { context in
            UIApplication.shared.windows.first?.rootViewController?.view.layer.render(in: context.cgContext)
        }
        return image
    }
    
    func uploadScreenshot(_ image: UIImage) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let screenshotRef = storageRef.child("screenshots/\(UUID().uuidString).png")
        if let imageData = image.pngData() {
            screenshotRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading screenshot: \(error.localizedDescription)")
                } else {
                    print("Screenshot uploaded successfully")
                }
            }
        }
    }
    
    
    @MainActor  func saveoutfit() {
        @State var renderedImage = Image(systemName: "photo")
        @Environment(\.displayScale) var displayScale
        let storageRef =  Storage.storage().reference()
        let path = "Saved Collages/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let renderer = ImageRenderer(content: SelectedItemsView())
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            let imageData = uiImage.jpegData(compressionQuality: 0.8)!
            let uploadTask = fileRef.putData(imageData , metadata: nil) { (metadata, error) in
                guard error == nil, metadata != nil else {
                    print("Error uploading image:", error as Any)
                    return
                }
                
                let db = Firestore.firestore()
                db.collection("Saved Collages").document(outfitid).setData([
                    "title": title,
                    "tag": tag,
                    "url": path
                ]) { error in
                    guard error == nil else {
                        print("Error saving data:", error as Any)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        // Update the UI with the newly saved image
                    }
                }
            }
        }
    }     
}

struct saveOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        saveOutfitView()

    }
}
