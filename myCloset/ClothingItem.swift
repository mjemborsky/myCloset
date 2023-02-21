//
//  ClothingItem.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 2/21/23.
//

import Foundation
class ClothingItem {

    var ItemID: Int
    var ItemTag: String
    var ItemPhoto: String


    /// constructor
    init(newID: Int, newTag: String, newPhoto: String) {
        self.ItemID = newID
        self.ItemTag = newTag
        self.ItemPhoto = newPhoto
    }
}
