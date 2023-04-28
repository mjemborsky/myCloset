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
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(username)
        docRef.getDocument { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                if let data = snapshot.data(){
                    let bio = data["bio"] as? String ?? ""
                    let user = UserProfile(username: username, bio: bio)
                    DispatchQueue.main.async {
                        self.user.append(user)
                    }
                }
            }
        }
    }
}
