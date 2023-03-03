//  post.swift
//  myCloset
//  Created by Michael Emborsky on 2/21/23.

import Foundation

struct Post {
    //  Description: Data class for storing posts of outfits, which are stored to the post
    //               database. Types of information stored includes post number, date added,
    //               likes, etc...
    var postNumber: Int
    var postTime: NSDate
    var postDescription: String
    var postLikes: [UserProfile]
    var postTags: [String]
    var postImageLink: String?
    var outfitPosted: outfit
    var createdBy: UserProfile
    
    
    init(postNumber: Int, outfitPosted: outfit, createdBy: UserProfile) {
        self.postNumber = postNumber
        self.postTime = NSDate()
        self.postDescription = String()
        self.postLikes = []
        self.postTags = []
        self.postImageLink = String()
        self.outfitPosted = outfitPosted
        self.createdBy = createdBy
    }
    
    func createPost() {
    }
}
//not sure how to format NSDate here
let SAMPLE_POST:[Post] = [
    //Post(postNumber: 1, postTime: NSDate, postDescription: "My favorite outfit", postLikes: [], postTags: [], postImageLink: "favorite_outfit.heic"),
    //Post(postNumber: 2, postTime: NSDate, postDescription: "Beach Day", postLikes: [], postTags: [], postImageLink: "beach_outfit.heic"),
    //Post(postNumber: 3, postTime: NSDate, postDescription: "At the concert!", postLikes: [], postTags: [], postImageLink: "rockstar_outfit.heic")
]
