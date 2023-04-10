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

    

    //constructor

    init(id: String, ItemTag: String) {

        self.id = id

        self.ItemTag = ItemTag

    }

    

}



let SAMPLE_ITEM:[ClothingItem] = [

    ClothingItem(id:"black-dress.heic", ItemTag:"dress"),

    //ClothingItem(ItemTag:"bottom", id:"blue-jeans.heic"),

    //ClothingItem(ItemTag:"shoes", id:"white-sneakers.heic"),

    //ClothingItem(ItemTag:"jewelry", id:"diamond-necklace.heic")

]

