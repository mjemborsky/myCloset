// FeedView.swift
// myCloset
// Created by Michael Emborsky on 3/3/23.

// Main Feed/Home View
// - Sets up page UI and pulls posts from a database. Uses the postCell formatting to format each one

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

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
    // List to store posts with getAllPosts()
    @State private var postsInProgress = [Post]()
    @State private var usersInProgress = [UserProfile]()
    var userEmail: String
    // View
    var body: some View {
        ZStack {
            NavigationView  {
                ScrollView(.vertical) {
                    Divider()
                        .foregroundColor(.gray)
                    // Displaying Posts - Iterates through list of posts pulled from
                    // database and displays each in PostCell format
                    ForEach(postsInProgress) { Post in
                        PostCell(post: Post, userEmail: userEmail, users: usersInProgress, allPosts: postsInProgress)
                    }
                    Divider()
                        .foregroundColor(.gray)
                    Spacer()
                }
                // Calling to retrieve posts
                .onAppear {
                    getAllPost()
                    getUsers()
                }
                .refreshable {
                    getAllPost()
                }
            }
            //Edit appearance of top navigation bar (currently not displaying?)
            .navigationTitle("myCloset")
            .navigationBarTitleDisplayMode(.inline)
            // SideMenu View and Conditionals to switch to other views
            MenuView(isOpen: $toggleMenu, feedSelected: $willMoveToFeed, searchSelected: $willMoveToSearch, closetSelected: $willMoveToCloset, profileSelected: $willMoveToProfile, hideFeed: $isHidden)
//                .fullScreenCover(isPresented: $willMoveToSearch) {
//                    SearchView()
//                }
                .fullScreenCover(isPresented: $willMoveToCloset) {
                    ClosetView(userEmail: userEmail, users: usersInProgress, posts: postsInProgress)
                        .environmentObject(ClothingItemManager())
                }
                .fullScreenCover(isPresented: $willMoveToProfile) {
//                    profileView(user: usersInProgress[0], posts: postsInProgress)
                    if let index = usersInProgress.firstIndex(where: {$0.email == userEmail}) {
                        profileView(user: usersInProgress[index], allUsers: usersInProgress, posts: postsInProgress, userEmail: userEmail)
                    }
                    // This else loop is for if we are running it in previews --- take out when done
                }
                .onAppear {
                    returnToView()
                }
            
        }
    }
    
    /**
     Function: getAllPost()
     Description: Main Function for pulling posts from database. Iterates through each post in database and creates
        a new post from the data, including the post image which is pulled from Firebase storage.
     Parameters: None
     Returns: None (Updates list of posts (state variable for FeedView))
     */
    func getAllPost() {
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        let ref = db.collection("Posts").order(by: "postTime", descending: true)
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
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
                    let fileRef = storageRef.child(postImage)
                    fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if error == nil && data != nil {
                            if let image = UIImage(data: data!) {
                                let post = Post(id: idUUID ?? UUID(), postTime: postDate, postCreator: postCreator, postDescription: postDescription, postLikes: postLikes, postSaves: postSaves, postTags: postTags, postImage: image)
                                DispatchQueue.main.async {
                                    postsInProgress.append(post)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func getUsers() {
        let db = Firestore.firestore()
        db.collection("Users").getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let username = data["username"] as! String
                    let bio = data["bio"] as? String ?? ""
                    let email = data["email"] as! String
                    let user = UserProfile(username: username, email: email, bio: bio)
                    DispatchQueue.main.async {
                        usersInProgress.append(user)
                    }
                }
            }
        }
    }
    /**
     Function:
     Description:
     Parameters: None
     Returns: None
     */
    func returnToView() {
        if willMoveToFeed {
            toggleMenu.toggle()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(userEmail: "michaelemborsky@gmail.com")
    }
}
