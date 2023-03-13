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
    var body: some View {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "person.crop.circle.fill")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "gear")
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
