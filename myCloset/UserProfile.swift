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
    var email: String
    var bio: String?
    var profileImage: UIImage?
    
    init(username: String, email: String, bio: String?=nil, profileImage: UIImage?=nil) {
        self.username = username
        self.email = email
        self.bio = bio
        self.profileImage = profileImage
    }
}

let SAMPLE_PROFILE:[UserProfile] = [
    UserProfile(username: "Bob01" , email: "joe@gmail.com", bio: "Love movies and cooking"),
    UserProfile(username: "Alice_Woods", email: "joe@gmail.com", bio: "UNCW '23"),
    UserProfile(username: "ClaireM", email: "joe@gmail.com", bio: "Wilmington, NC")
]

