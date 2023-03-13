//  post.swift
//  myCloset
//  Created by Michael Emborsky on 2/21/23.

import Foundation
let currentdate = Date()

struct Post: Identifiable {
    //  Description: Data class for storing posts of outfits, which are stored to the post
    //               database. Types of information stored includes post number, date added,
    //               likes, etc...
    // Need some generator for ID, that increments with every post in the system
    let id = UUID()
    var postTime: Date
    var postCreator: UserProfile
    var postDescription: String
    var postLikes: [UserProfile]
    var postSaves: [UserProfile]
    var postTags: [String]
    var postImage: String?
    var linkedOutfit: outfit
    
    
    init(id: UUID, postTime: Date, postCreator: UserProfile, postDescription: String, postLikes: [UserProfile], postSaves: [UserProfile], postTags: [String], postImage: String?, linkedOutfit: outfit) {
        self.postCreator = postCreator
        self.postTime = postTime
        self.postDescription = postDescription
        self.postLikes = postLikes
        self.postSaves = postSaves
        self.postTags = postTags
        self.postImage = postImage
        self.linkedOutfit = linkedOutfit
    }
    
    func createPost() {
    }
}
//sample data
let SAMPLE_POST: [Post] = Array(repeating: (Post(id: UUID(), postTime: currentdate, postCreator: SAMPLE_PROFILE[1], postDescription: "My favorite outfit", postLikes: [SAMPLE_PROFILE[1], SAMPLE_PROFILE[2]], postSaves: [SAMPLE_PROFILE[1], SAMPLE_PROFILE[2]], postTags: ["cardigan", "comfort"], postImage: "favorite_outfit.heic", linkedOutfit: SAMPLE_OUTFIT[1])), count: 10
//    Post(id: UUID(), postTime: currentdate, postCreator: SAMPLE_PROFILE[1], postDescription: "Beach Day", postLikes: [SAMPLE_PROFILE[2]], postSaves: [SAMPLE_PROFILE[1], SAMPLE_PROFILE[3]], postTags: ["beach", "swimming"], postImage: "beach_outfit.heic", linkedOutfit: SAMPLE_OUTFIT[1]),
//    Post(id: UUID(), postTime: currentdate, postCreator: SAMPLE_PROFILE[1], postDescription: "At the Concert!", postLikes: [SAMPLE_PROFILE[1], SAMPLE_PROFILE[2], SAMPLE_PROFILE[3]], postSaves: [SAMPLE_PROFILE[2], SAMPLE_PROFILE[3]], postTags: ["boujee", "rave"], postImage: "rockstar_outfit.heic", linkedOutfit: SAMPLE_OUTFIT[1]),
)



// need function to reformat date into string
func getDateinString(Date: Date) -> String {
    let timestamp = Date.timeIntervalSince1970
    return String(timestamp)
}
