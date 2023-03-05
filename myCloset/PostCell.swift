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
            HStack (spacing: 10) {
                // this is the user profile pic on each post
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                // this is the username of post creator
                Text(getUsername(UserProfile:post.postCreator))
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal, 8)
            
            // insert image
            Image(systemName: "photo.artframe")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width)
            
            // another HStack for like and save option
            HStack (spacing: 16) {
                // should be replaced with a heart or like button
                Image(systemName: "heart")
                Text("\((post.postLikes).count) Likes")
                    .font(.headline)
                
                Spacer()
                
                // should be replaced with a save button
                Image(systemName: "bookmark")
            }
            .font(.title2)
            .padding(6)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text((getUsername(UserProfile:post.postCreator)))
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
}

struct PostCellPreview_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: SAMPLE_POST[0])
    }
}

