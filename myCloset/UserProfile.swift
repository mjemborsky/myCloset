//
//  UserProfile.swift
//  myCloset
//
//  Created by Taylor  on 2/22/23.
//

import Foundation
import SwiftUI

struct UserProfile {
    var username: String
    var bio: String?
    var profileImage: UIImage?
    
    init(username: String, bio: String?=nil, profileImage: UIImage?=nil) {
        self.username = username
        self.bio = bio
        self.profileImage = profileImage
    }
}

let SAMPLE_PROFILE:[UserProfile] = [
    UserProfile(username: "Bob01" , bio: "Love movies and cooking"),
    UserProfile(username: "Alice_Woods", bio: "UNCW '23"),
    UserProfile(username: "ClaireM", bio: "Wilmington, NC")
]

// simple getter function to pass in a profile and recieve back username as a string
func getUsername(UserProfile: UserProfile) -> String {
    return UserProfile.username
}
