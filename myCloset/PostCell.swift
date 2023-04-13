// PostCell.swift
// myCloset
// Created by Michael Emborsky on 3/3/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI

// UI for an individual post "cell" - responsible for all formatting of buttons, etc.. of an individual post. This is used by feedView to format all posts.

struct PostCell: View {
    @State private var liked: Bool = false
    let post: Post
    let images: [UIImage]
    // could include "placeholder" eventually using .redacted, for when it is loading
    var body: some View {
        // Check if the post is liked by user here
        // VStack for all post info
        VStack {
            // HStack for profile image, profile username
            HStack (spacing: 10) {
                //  Display image at index 1 from array of post images (userImage).
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                // this is the username of post creator
                Text(post.postCreator)
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal, 8)
            // Display image at index 0 from array of post images (postImage).
            Image(uiImage: images[0])
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.width)
            // another HStack for like and save option
            HStack (spacing: 16) {
                // should be replaced with a heart or like button
                if liked {
                    Button(action: {
                        liked.toggle()
                    }) {
                        Image(systemName: "heart")
                    }
                }
                else {
                    Button(action: {
                        liked.toggle()
                    }) {
                        Image(systemName: "heart.fill")
                    }
                }
                Text(String((post.postLikes).count) + " Likes")
                    .font(.headline)
                
                Spacer()
                
                // should be replaced with a save button
                Image(systemName: "bookmark")
            }
            .font(.title2)
            .padding(6)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(post.postCreator)
                        .font(.headline)
                    + Text(" " + post.postDescription)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Text(getDateinString(Date:post.postTime))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            Spacer()
            Spacer()
        }
    }
    //  FUNCTIONS NEEDED
        // likeAction
        // - adds username to array of post's likes in database
        // unlikeAction
        // - removes username from array of post's likes in database
        // saveAction
        // - adds username to array of post's saves in database
        // unsaveAction
        // - adds username to array of post's saves in database
    
        // interactions when clicking on userProfile, and potentially post
}

//struct PostCellPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCell(post: SAMPLE_POST)
//    }
//}

