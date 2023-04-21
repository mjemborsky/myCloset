//
//  ClothingItem.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 2/21/23.
//

import Foundation
import SwiftUI


struct ClothingItem{

    var ItemTag: String

    var ImageURL: UIImage

    

    //constructor

    init(ItemTag: String, ImageURL: UIImage) {

        self.ItemTag = ItemTag

        self.ImageURL = ImageURL

    }

    

}



let SAMPLE_ITEM:[ClothingItem] = [

    //ClothingItem(id:"black-dress.heic", ItemTag:"dress"),

    //ClothingItem(ItemTag:"bottom", id:"blue-jeans.heic"),

    //ClothingItem(ItemTag:"shoes", id:"white-sneakers.heic"),

    //ClothingItem(ItemTag:"jewelry", id:"diamond-necklace.heic")

]

