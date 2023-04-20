//
//  SearchObservableObject.swift
//  myCloset
//
//  Created by Michael Emborsky on 4/9/23.
//

//import Foundation
//import FirebaseFirestore
//import Firebase
//
//class SearchObservableObject: ObservableObject {
//    var userData: [UserLoginData] = []
//    @Published var userSearchResults: UserLoginData
//    var tagData: [String] = []
//    @Published var tagSearchResults: PersonNameComponents
//    
//    init() {
//        let db = Firestore.firestore()
//        let postCollection = db.collection("Posts")
//        let userCollection = db.collection("Users")
//        
//        
//        userData =
//        func search(drinkName: String) {
//                let databaseRef = Fire.database().reference().child("Drinks")
//                let query = databaseRef.queryOrdered(byChild: "name").queryStarting(atValue: drinkName).queryEnding(atValue: "\(drinkName)\\uf8ff")
//
//                query.observeSingleEvent(of: .value) { (snapshot) in
//                    guard snapshot.exists() != false else { return }
//                    //print(snapshot.value)
//                    DispatchQueue.main.async {
//                        // Update TextFields here
//                    }
//                }
//        }// get data from database, save post data (tags) as tagData with link to post and user data as userData with link to user profile
//    }
//}
