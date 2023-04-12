// FeedView.swift
// myCloset
// Created by Michael Emborsky on 3/3/23.

// Main Feed/Home View
// - Sets up page UI and pulls posts from a database. Uses the postCell formatting to format each one

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct FeedView: View {
    ///SideMenu Variables
    // Variable for if sidemenu is showing or not
    @State private var toggleMenu: Bool = false
    // Variables for which view will be switched to next (from sidemenu)
    @State private var willMoveToFeed: Bool = false
    @State private var willMoveToSearch: Bool = false
    @State private var willMoveToCloset: Bool = false
    @State private var willMoveToProfile: Bool = false
    // Variable to hide feedview
    @State private var isHidden: Bool = false
    /// Database Variables
    // List to store posts with getAllPosts()
    @State private var postsInProgress = [Post]()
    @State private var imagesInProgress = [UIImage]()
    @State private var userProfileImages = [UIImage]()
    // Main View
    var body: some View {
        ZStack {
            NavigationView  {
                ScrollView(.vertical) {
                    Divider()
                        .foregroundColor(.gray)
                    // Displaying Posts
                    ForEach(postsInProgress) { Post in
                        PostCell(post: Post, images: imagesInProgress)
                    }
                    Spacer()
                }
                // Calling to retrieve posts
                .task {
                    await getAllPost()
                }
            }
            //Edit appearance of top navigation bar (currently not displaying?)
                .navigationTitle("myCloset")
                .navigationBarTitleDisplayMode(.inline)
            
            // SideMenu View and Conditionals to switch to other views
            MenuView(isOpen: $toggleMenu, feedSelected: $willMoveToFeed, searchSelected: $willMoveToSearch, closetSelected: $willMoveToCloset, profileSelected: $willMoveToProfile, hideFeed: $isHidden)
                .fullScreenCover(isPresented: $willMoveToSearch) {
                    SearchView()
                }
                .fullScreenCover(isPresented: $willMoveToCloset) {
                    ClosetView()
                        .environmentObject(ClothingItemManager())
                }
                .fullScreenCover(isPresented: $willMoveToProfile) {
                    profileView()
                }
                .onAppear {
                    returnToView()
                }
            
        }
    }
    
    /*
     function: getAllPost()
     Asynchronous function with no arguments or returns that accesses all posts in the database, saves each post under the Post class and appends the created post to the list of all posts.
     */
    func getAllPost() async {
            let db = Firestore.firestore()
            let storageRef = Storage.storage().reference()
            db.collection("Posts").getDocuments { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        var userImageLink: String
                        let data = document.data()
                        let id = data["ID"] as! String
                        let idUUID = UUID(uuidString: id)
                        let postTime = data["postTime"] as? Double ?? 0.0
                        let postDate = Date(timeIntervalSince1970: postTime)
                        let postCreator = data["postCreator"] as? String ?? ""
                        let postDescription = data["postDescription"] as? String ?? ""
                        let postLikes = data["postLikes"] as? [String] ?? []
                        let postSaves = data["postSaves"] as? [String] ?? []
                        let postTags = data["postTags"] as? [String] ?? []
                        let postImage = data["postImage"] as? String ?? ""
                        let linkedOutfit = data["linkedOutfit"] as? String ?? ""
                        let linkedUser = data["linkedUser"] as? String ?? ""
                        let userRef = db.collection("Users").document(linkedUser)
                        userRef.getDocument(source: .cache) { (document, error) in
                            if let document = document {
                                let imageLink = document.get("profileImage") as! String
                                userImageLink = imageLink
                            }
                        }
                        let post = Post(id: idUUID ?? UUID(), postTime: postDate, postCreator: postCreator, postDescription: postDescription, postLikes: postLikes, postSaves: postSaves, postTags: postTags, postImage: postImage, linkedOutfit: linkedOutfit)
                        let fileRef = storageRef.child(postImage)
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error == nil && data != nil {
                                if let image = UIImage(data: data!) {
                                    DispatchQueue.main.async {
                                        postsInProgress.append(post)
                                        imagesInProgress.append(image)
                                    }
                                }
                                
                            }
                        }
                        await getUserImage(path: userImageLink)
                    }
                }
            }
    }
    func getUserImage(path: String) {
        let link = "images/\(path).jpg"
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(link)
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                if let image = UIImage(data: data!) {
                    DispatchQueue.main.async {
                        imagesInProgress.append(image)
                    }
                }
                
            }
        }
    }
    
    
    func returnToView() {
        if willMoveToFeed {
            toggleMenu.toggle()
        }
    }
}


struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
