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
        let ref = db.collection("Users").document(username)
        ref.getDocument { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            let snapshot = snapshot
            let bio = snapshot!.value(forKey: "bio") as? String ?? ""
            let user = UserProfile(username: username, bio: bio)
            DispatchQueue.main.async {
                self.user.append(user)
            }
        
        }
    }
}
