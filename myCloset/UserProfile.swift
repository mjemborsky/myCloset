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
    var following: Int
    var followers: Int
    
    init(username: String, bio: String, following: Int, followers: Int) {
        self.username = username
        self.bio = bio
        self.following = following
        self.followers = followers
    }
}
let SAMPLE_PROFILE:[UserProfile] = [
    UserProfile(username: "Bob01", bio: "Love movies and cooking", following: 240, followers: 300),
    UserProfile(username: "Alice_Woods", bio: "UNCW '23", following: 30, followers: 50),
    UserProfile(username: "ClaireM", bio: "Wilmington, NC", following: 1000, followers: 500),
]
