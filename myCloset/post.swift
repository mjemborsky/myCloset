//  post.swift
//  myCloset
//  Created by Michael Emborsky on 2/21/23.

import Foundation

class Post {
    //  Description: Data class for storing posts of outfits, which are stored to the post
    //               database. Types of information stored includes post number, date added,
    //               likes, etc...
    var postNumber: Int
    var postTime: NSDate
    var postDescription: String
    var postLikes: Int
    var postTags: [String]
    var postImageLink: String?
    
    
    init(postNumber: Int) {
        self.postNumber = postNumber
        self.postTime = NSDate()
        self.postDescription = String()
        self.postLikes = Int()
        self.postTags = []
        self.postImageLink = String()
    }
    
    func createPost() {
    }
}
