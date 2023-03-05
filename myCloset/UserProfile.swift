//
//  UserProfile.swift
//  myCloset
//
//  Created by Taylor  on 2/22/23.
//

import Foundation

struct UserProfile {
    
    var username: String
    var bio: String
    var following: [UserProfile]
    var followers: [UserProfile]
    var following_count: Int
    var followers_count: Int
    var createdPosts: [Post]
    var likedPosts: [Post]
    
    init(username: String, bio: String, following: [UserProfile], followers: [UserProfile]) {
        self.username = username
        self.bio = bio
        self.following = []
        self.followers = []
        self.following_count = following.count
        self.followers_count = followers.count
        self.createdPosts = []
        self.likedPosts = []
    }
}

let SAMPLE_PROFILE:[UserProfile] = [
    UserProfile(username: "Bob01", bio: "Love movies and cooking", following: [], followers: []),
    UserProfile(username: "Alice_Woods", bio: "UNCW '23", following: [], followers: []),
    UserProfile(username: "ClaireM", bio: "Wilmington, NC", following: [], followers: [])
]

// simple getter function to pass in a profile and recieve back username as a string
func getUsername(UserProfile: UserProfile) -> String {
    return UserProfile.username
}
