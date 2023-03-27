//
//  outfit.swift
//  myCloset
//
//  Created by alexa on 2/21/23.
//

import Foundation

struct outfit: Identifiable{
    let id = UUID()
    var title: String
    var outfitTag: String
    var  itemsUsed: [ClothingItem]
    
    init(id: UUID, title: String, tag: String, itemsUsed: [ClothingItem]){
        self.title = title
        self.outfitTag = tag
        self.itemsUsed = itemsUsed
    }
}
//needs ClothingItem for sample posts
let SAMPLE_OUTFIT:[outfit] = [
    outfit(id: UUID(), title:"Date", tag:"dress", itemsUsed:[]),
    outfit(id: UUID(), title:"Picnic", tag:"skirt", itemsUsed:[]),
    outfit(id: UUID(), title:"School", tag:"pants", itemsUsed:[])
]

 
