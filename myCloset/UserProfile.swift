//
//  UserProfile.swift
//  myCloset
//
//  Created by Taylor  on 2/22/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
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

//func getUserInfo(username: String) -> UserProfile {
//    let db = Firestore.firestore()
//    let storageRef = Storage.storage().reference()
//    db.collection("Users").getDocuments { snapshot, error in
//        guard error == nil else {
//            print(error!.localizedDescription)
//            return
//        }
//        if let snapshot = snapshot {
//            for document in snapshot.documents {
//                let data = document.data()
//                let usernameTwo = data["username"] as! String
//                if (username == usernameTwo) {
//                    let bio = data["bio"] as? String ?? ""
////                    let profileImageLink = data["profileImage"] as? String ?? ""
//                    let user = UserProfile(username: usernameTwo, bio: bio)
//                    DispatchQueue.main.async {
//                        return user
//                    }
////                    if profileImageLink == "" {
////                        let user = UserProfile(username: usernameTwo, bio: bio)
////                        userProfile = user
////                    } else {
////                        let fileRef = storageRef.child(profileImageLink)
////                        fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
////                            if error == nil && data != nil {
////                                let image = UIImage(data: data!)
////                                let user = UserProfile(username: usernameTwo, bio: bio, profileImage: image)
////                                userProfile = user
////                            }
////                        }
////                    }
//                }
//                else {
//                    break
//                }
//            }
//        }
//    }

