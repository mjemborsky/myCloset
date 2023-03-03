//
//  outfit.swift
//  myCloset
//
//  Created by alexa on 2/21/23.
//

import Foundation
struct outfit{
    var title: String
    var outfitTag: String
    var  outfitID: Int
    var  itemsUsed: [ClothingItem]
    
    init(title: String, tag: String, outfitID: Int, itemsUsed: [ClothingItem]){
        self.title = title
        self.outfitTag = tag
        self.outfitID = outfitID
        self.itemsUsed = itemsUsed
    }
}
//needs ClothingItem for sample posts
let SAMPLE_OUTFIT:[outfit] = [
    outfit(title:"Date", tag:"dress", outfitID:1, itemsUsed:[]),
    outfit(title:"Picnic", tag:"skirt", outfitID:2, itemsUsed:[]),
    outfit(title:"School", tag:"pants", outfitID:3, itemsUsed:[])
]

 
