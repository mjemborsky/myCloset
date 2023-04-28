//
//  ProfileViewManager.swift
//  myCloset
//
//  Created by Michael Emborsky on 4/28/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ProfileViewManager: ObservableObject {
    @State var user: [UserProfile] = []

    init(username: String) {
        fetchUser(username: username)
    }

    func fetchUser(username: String) {
        user.removeAll()
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        let ref = db.collection("Users")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let usernameTwo = data["username"] as? String ?? ""
                    if username == usernameTwo {
                        let bio = data["bio"] as? String ?? ""
                        let profileImageLink = data["profileImage"] as? String ?? ""
                        let fileRef = storageRef.child(profileImageLink)
                        fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            if error == nil && data != nil {
                                if let image = UIImage(data: data!) {
                                    let user = UserProfile(username: usernameTwo, bio: bio, profileImage: image )
                                    DispatchQueue.main.async {
                                        self.user.append(user)
                                    }
                                }
                            }
                        }
                    } else {
                        break
                    }
                }
            }
        }
    }

}
