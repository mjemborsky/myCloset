//
//  PostViewModel.swift
//  myCloset
//
//  Created by Michael Emborsky on 3/3/23.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    // This is where we will pull from the database and initialize the posts. Into an array of posts
    
    
    // Delete when database is set up and integrated
    init() {
        let post1 = SAMPLE_POST
    }
}
