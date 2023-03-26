//
//  FeedView.swift
//  myCloset
//
//  Created by Michael Emborsky on 3/3/23.
//  

import SwiftUI

// driving Post page
// Sets up page UI and pulls posts from a database. Uses the postCell formatting to format each one


struct FeedView: View {
    @State private var toggleMenu: Bool = false
    var body: some View {
        ZStack {
            NavigationView  {
                ScrollView(.vertical) {
                    Divider()
                        .foregroundColor(.gray)
                    // display posts here
                    // REPLACE with pulling with database when implemented
                    ForEach(SAMPLE_POST) { Post in
                        PostCell(post: Post)
                        Spacer()
                    }
                }
               
                //Edit appearance of top links (including settings link?)
                .navigationTitle("myCloset")
                .navigationBarTitleDisplayMode(.inline)
            }
            MenuView(isOpen: $toggleMenu)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
