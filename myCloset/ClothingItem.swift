//
//  ClothingItem.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 2/21/23.
//

import Foundation

struct ClothingItem {
    
    var ItemID: Int
    var ItemTag: String
    var ItemPhoto: String
    
    /// constructor
    init(ItemID: Int, ItemTag: String, ItemPhoto: String) {
        self.ItemID = ItemID
        self.ItemTag = ItemTag
        self.ItemPhoto = ItemPhoto
    }
}
let SAMPLE_ITEM:[ClothingItem] = [
    ClothingItem(ItemID:1, ItemTag:"dress", ItemPhoto:"black-dress.heic"),
    ClothingItem(ItemID:2, ItemTag:"bottom", ItemPhoto:"blue-jeans.heic"),
    ClothingItem(ItemID:3, ItemTag:"shoes", ItemPhoto:"white-sneakers.heic")
]
