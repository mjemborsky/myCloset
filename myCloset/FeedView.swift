//
//  FeedView.swift
//  myCloset
//
//  Created by Michael Emborsky on 3/3/23.
//  

import SwiftUI
import FirebaseFirestore



// driving Post page
// Sets up page UI and pulls posts from a database. Uses the postCell formatting to format each one




struct FeedView: View {
    @State private var toggleMenu: Bool = false
    @State private var willMoveToFeed: Bool = false
    @State private var willMoveToSearch: Bool = false
    @State private var willMoveToCloset: Bool = false
    @State private var willMoveToProfile: Bool = false
    @State private var isHidden: Bool = false
    @State private var postsInProgress = [Post]()
    var pickedPost: Post?
    var body: some View {
        ZStack {
            NavigationView  {
                ScrollView(.vertical) {
                    Divider()
                        .foregroundColor(.gray)
                    // display posts here
                    // REPLACE with pulling with database when implemented
                    
                    ForEach(postsInProgress) { Post in
                        PostCell(post: Post)
                    }
                    Spacer()
                }
                .task {
                    await getAllPost()
                }
            }
            //Edit appearance of top links (including settings link?)
            .navigationTitle("myCloset")
            .navigationBarTitleDisplayMode(.inline)
            MenuView(isOpen: $toggleMenu, feedSelected: $willMoveToFeed, searchSelected: $willMoveToSearch, closetSelected: $willMoveToCloset, profileSelected: $willMoveToProfile, hideFeed: $isHidden)
                .sheet(isPresented: $willMoveToSearch) {
                    //                    FeedView()
                }
                .sheet(isPresented: $willMoveToCloset) {
                    ClosetView()
                }
                .sheet(isPresented: $willMoveToProfile) {
                    //                    FeedView()
                }
            
        }
    }
        func getAllPost() async {
            let db = Firestore.firestore()
            db.collection("Posts").getDocuments { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        let id = data["ID"] as? String ?? ""
                        let idUUID = UUID(uuidString: id)
                        let postTime = data["postTime"] as? TimeInterval ?? TimeInterval()
                        let postDate = Date(timeIntervalSince1970: postTime)
                        let postCreator = data["postCreator"] as? String ?? ""
                        let postDescription = data["postDescription"] as? String ?? ""
                        let postLikes = data["postLikes"] as? [String] ?? []
                        let postSaves = data["postSaves"] as? [String] ?? []
                        let postTags = data["postTags"] as? [String] ?? []
                        let postImage = data["postImage"] as? String ?? ""
                        let linkedOutfit = data["linkedOutfit"] as? String ?? ""
                        let post = Post(id: idUUID ?? UUID(), postTime: postDate, postCreator: postCreator, postDescription: postDescription, postLikes: postLikes, postSaves: postSaves, postTags: postTags, postImage: postImage, linkedOutfit: linkedOutfit)
                        DispatchQueue.main.async {
                            postsInProgress.append(post)
                        }
                    }
                }
            }
        }
}




    

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
