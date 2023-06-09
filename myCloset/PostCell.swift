// PostCell.swift
// myCloset
// Created by Michael Emborsky on 3/3/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

// UI for an individual post "cell" - responsible for all formatting of buttons, etc.. of an individual post. This is used by feedView to format all posts.

struct PostCell: View {
    var post: Post
    var userEmail: String
    var users: [UserProfile]
    var allPosts: [Post]
    @State private var liked: Bool = false
    @State private var saved: Bool = false
    // could include "placeholder" eventually using .redacted, for when it is loading
    var body: some View {
        // Check if the post is liked by user here
        // VStack for all post info
        VStack {
            // HStack for profile username
            HStack (spacing: 10) {
                // this is the username of post creator
                // if conditional that tests for an index where the post creator will equal the user.
                // If it matches, tapping the username will bring the user to profileView with the selected users information
                if let index = users.firstIndex(where: {$0.username == post.postCreator}) {
                    NavigationLink(destination: profileView(user: users[index], allUsers: users, posts: allPosts, userEmail: userEmail), label: {
                        Text(post.postCreator)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    })
                }
                Spacer()
            }
            .padding(.horizontal, 8)
            // Display post image.
            Image(uiImage: post.postImage)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.width)
            // another HStack for like and save option
            HStack (spacing: 16) {
                // Like Button
                // Conditional for if post is already liked
                if liked {
                    Button(action: {
                        // Calls to switch boolean of liked to false and removes like from database
                        liked.toggle()
                        unlikePost()
                    }, label: {
                        // If liked, heart will be filled. Still having issues currently with the count being off by 1
                        // if the user has it liked when the page loads.
                        Image(systemName: "heart.fill")
                        Text(String(post.postLikes.count+1))
                            .font(.headline)
                    })
                }
                // Conditional for if post is not liked
                else {
                    Button(action: {
                        // Calls to switch boolean of liked to true and adds like in database
                        liked.toggle()
                        likePost()
                    }, label: {
                        // If not liked, the heard will not be filled.
                        Image(systemName: "heart")
                        Text(String(post.postLikes.count))
                            .font(.headline)
                    })
                }
                Spacer()
                // Save Button
                // Conditional for if user has post saved already
                if saved {
                    Button(action: {
                        // Calls to switch boolean of saved to false and removes save from database
                        saved.toggle()
                        unsavePost()
                    }) {
                        // The save icon will be filled if the user has the post saved
                        Image(systemName: "bookmark.fill")
                    }
                }
                else {
                    Button(action: {
                        // Calls to switch boolean of saved to true and adds save in database
                        saved.toggle()
                        savePost()
                    }) {
                        // The save icon will be not filled if the user has not saved the post
                        Image(systemName: "bookmark")
                    }
                }
            }
            .font(.title2)
            .padding(6)
            .onAppear {
                // Checks if post is liked or save when it appears
                isLiked()
                isSaved()
            }
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    if let index = users.firstIndex(where: {$0.username == post.postCreator}) {
                        NavigationLink(destination: profileView(user: users[index], allUsers: users, posts: allPosts, userEmail: userEmail), label: {
                            Text(post.postCreator)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        })
                    }
                    Text(" " + post.postDescription)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Text(getDateinString(Date:post.postTime))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            Spacer()
            Spacer()
            Divider()
        }
    }
    /**
     Function: isLiked()
     Description:
     Parameters: None
     Returns: None
     */
    func isLiked() {
        if (post.postLikes.contains("username2")) {
            liked = true
        } else {
            liked = false
        }
    }
    /**
     Function: isLiked()
     Description:
     Parameters: None
     Returns: None
     */
    func isSaved() {
        if (post.postSaves.contains("username2")) {
            saved = true
        } else {
            saved = false
        }
    }
    /**
     Function: isLiked()
     Description:
     Parameters: None
     Returns: None
     */
    func likePost() {
        let db = Firestore.firestore()
        let docRef = db.collection("Posts").document(post.id.uuidString)
        docRef.updateData([
            "postLikes": FieldValue.arrayUnion(["username2"])
        ])
    }
    /**
     Function: isLiked()
     Description:
     Parameters: None
     Returns: None
     */
    func unlikePost() {
        let database = Firestore.firestore().collection("Posts")
        let postRef = database.document(post.id.uuidString)
        postRef.updateData([
            "postLikes": FieldValue.arrayRemove(["username2"])
        ])
    }
    /**
     Function: isLiked()
     Description:
     Parameters: None
     Returns: None
     */
    func savePost() {
        let db = Firestore.firestore()
        let docRef = db.collection("Posts").document(post.id.uuidString)
        docRef.updateData([
            "postSaves": FieldValue.arrayUnion(["username2"])
        ])
    }
    /**
     Function: 
     Description:
     Parameters: None
     Returns: None
     */
    func unsavePost() {
        let db = Firestore.firestore()
        let docRef = db.collection("Posts").document(post.id.uuidString)
        docRef.updateData([
            "postSaves": FieldValue.arrayRemove(["username2"])
        ])
    }
}
