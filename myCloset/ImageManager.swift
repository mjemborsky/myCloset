//
//  ImageManager.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 4/5/23.
//
import Foundation
import FirebaseStorage
import FirebaseFirestore
import UIKit

var selectedImage: UIImage?

func uploadPhoto(){

    // Make sure that the selected image property isn't nil
    guard selectedImage != nil else {
        return
    }

    // Create storage reference
    let storageRef =  Storage.storage().reference()

    // Turn our image into data
    let imageData = selectedImage!.jpegData(compressionQuality: 0.8)

    guard imageData != nil else {
        return
    }

    // Specify the file path and name
    let path = "images/\(UUID().uuidString).jpg"
    let fileRef = storageRef.child(path)

    // Upload that data
    let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
        // Check for errors

        if error == nil && metadata != nil {
            // Save a reference to the file in Firestore DB
            let db = Firestore.firestore()
            db.collection("images").document().setData(["url" : path])
        } // end error(uploadTask)
    } // end uploadTask
} // end UploadPhoto
