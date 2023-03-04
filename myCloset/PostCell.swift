//
//  PostCell.swift
//  myCloset
//
//  Created by Michael Emborsky on 3/3/23.
//

import SwiftUI

// UI for an individual post "cell" - responsible for all formatting of buttons, etc..
struct PostCell: View {
    let post: Post
    
    // could include "placeholder" eventually using .redacted, for when it is loading
    var body: some View {
        // VStack for all post info
        VStack {
            // HStack for profile image, profile username
            HStack {
                
            }
            // insert image
            // another HStack for like and save option
            HStack {
                
            }
        }
        
        
        Text(post.postDescription)
    }
}

