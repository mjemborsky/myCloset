//  post.swift
//  myCloset
//  Created by Michael Emborsky on 2/21/23.

import Foundation
import FirebaseFirestore
import Firebase

let currentdate = Date()
let database = Firestore.firestore()


struct Post: Identifiable {
    //  Description: Data class for storing posts of outfits, which are stored to the post
    //               database. Types of information stored includes post number, date added,
    //               likes, etc...
    // Need some generator for ID, that increments with every post in the system
    let id = UUID()
    var postTime: Date
    var postCreator: String
    var postDescription: String
    var postLikes: [String]
    var postSaves: [String]
    var postTags: [String]
    var postImage: String
    var linkedOutfit: String
    
    
    init(id: UUID, postTime: Date, postCreator: String, postDescription: String, postLikes: [String], postSaves: [String], postTags: [String], postImage: String, linkedOutfit: String) {
        self.postCreator = postCreator
        self.postTime = postTime
        self.postDescription = postDescription
        self.postLikes = postLikes
        self.postSaves = postSaves
        self.postTags = postTags
        self.postImage = postImage
        self.linkedOutfit = linkedOutfit
    }
    
    
    
    func getPostImageLink() -> String {
        return self.postImage
    }
    

}


//sample data
let SAMPLE_POST = Post(id: UUID(), postTime: currentdate, postCreator: "bob", postDescription: "My favorite outfit", postLikes: ["mary", "bob"], postSaves: ["steve", "joe"], postTags: ["cardigan", "comfort"], postImage: "favorite_outfit.heic", linkedOutfit: "blah")
//    Post(id: UUID(), postTime: currentdate, postCreator: SAMPLE_PROFILE[1], postDescription: "Beach Day", postLikes: [SAMPLE_PROFILE[2]], postSaves: [SAMPLE_PROFILE[1], SAMPLE_PROFILE[3]], postTags: ["beach", "swimming"], postImage: "beach_outfit.heic", linkedOutfit: SAMPLE_OUTFIT[1]),
//    Post(id: UUID(), postTime: currentdate, postCreator: SAMPLE_PROFILE[1], postDescription: "At the Concert!", postLikes: [SAMPLE_PROFILE[1], SAMPLE_PROFILE[2], SAMPLE_PROFILE[3]], postSaves: [SAMPLE_PROFILE[2], SAMPLE_PROFILE[3]], postTags: ["boujee", "rave"], postImage: "rockstar_outfit.heic", linkedOutfit: SAMPLE_OUTFIT[1]),




// need function to reformat date into string
func getDateinString(Date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "MM-dd-yyyy at HH:mm" //Specify your format that you want
    let strDate = dateFormatter.string(from: Date)
    return strDate

}


func createPost(postCreator: String, postDescription: String, postTags: [String], postImage: String, linkedOutfit: String) {
    let db = Firestore.firestore()
    let id = UUID().uuidString
    let date = Date()
    let timestamp = date.timeIntervalSince1970
    let postLikes = [String]()
    let postSaves = [String]()
    let ref = db.collection("Posts").document(id)
    ref.setData(["ID": id, "postTime": timestamp, "postCreator": postCreator, "postDescription": postDescription, "postLikes": postLikes, "postSaves": postSaves, "postTags": postTags, "postImage": postImage, "linkedOutfit": linkedOutfit ]) {error in
        if let error = error {
            print(error.localizedDescription)
        }
    }
}
