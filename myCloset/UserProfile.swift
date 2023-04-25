//
//  UserProfile.swift
//  myCloset
//
//  Created by Taylor  on 2/22/23.
//

import Foundation
import FirebaseAuth
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


//
//func getUserDetails() -> String {
//    if let user = Auth.auth().currentUser {
//        let userInfo = [String]()
//        let providerID: String = user.providerID
//        let uid: String = user.uid
//        let displayName: String = user.displayName ?? "username"
////        let photoURL: String = user.photoURL ?? "gs://mycloset-ea3a8.appspot.com/images/sample1.png"
//        let email: String = user.email ?? ""
//
//    }
//}
