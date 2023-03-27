//
//  ClothingItem.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 2/21/23.
//

import Foundation

struct ClothingItem: Identifiable{
    var id: String
    var ItemTag: String
    var ItemPhoto: String
    
    //constructor
    init(id: String, ItemTag: String, ItemPhoto: String) {
        self.id = id
        self.ItemTag = ItemTag
        self.ItemPhoto = ItemPhoto
    }
    
}

let SAMPLE_ITEM:[ClothingItem] = [
    ClothingItem(id:"1", ItemTag:"dress", ItemPhoto:"black-dress.heic"),
    ClothingItem(id:"2", ItemTag:"bottom", ItemPhoto:"blue-jeans.heic"),
    ClothingItem(id:"3", ItemTag:"shoes", ItemPhoto:"white-sneakers.heic")
]

