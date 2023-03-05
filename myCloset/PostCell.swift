//
//  PostCell.swift
//  myCloset
//
//  Created by Michael Emborsky on 3/3/23.
//

import SwiftUI

// UI for an individual post "cell" - responsible for all formatting of buttons, etc.. of an individual post. This is used by feedView to format all posts.
struct PostCell: View {
    let post: Post
    
    // could include "placeholder" eventually using .redacted, for when it is loading
    var body: some View {
        // VStack for all post info
        VStack {
            // HStack for profile image, profile username
            HStack (spacing: 16) {
                // this is the user profile pic on each post
                Image("favorite_outfit.heic")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                // this is the username of post creator
                Text(getUsername(UserProfile:post.postCreator))
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 8)
            
            // insert image
            Image("favorite_outfit.heic")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width)
            
            // another HStack for like and save option
            HStack (spacing: 16) {
                // should be replaced with a heart or like button
                Image(systemName: "heart")
                
                Spacer()
                
                // should be replaced with a save button
                Image(systemName: "bookmark")
            }
            .font(.title2)
            .padding(8)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\((post.postLikes).count) Likes")
                        .font(.headline)
                    Spacer()
                }
                
                Text((getUsername(UserProfile:post.postCreator)))
                    .font(.headline)
                
                + Text(" " + post.postDescription)
                     
                Text(getDateinString(Date:post.postTime))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct PostCellPreview_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: SAMPLE_POST[0])
    }
}

