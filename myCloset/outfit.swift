//
//  outfit.swift
//  myCloset
//
//  Created by alexa on 2/21/23.
//

import Foundation
class outfit{
    var title: String
    var outfitTag: String
    var  outfitID: Int
    
    init(title: String, tag: String, outfitID: Int){
        self.title = title
        self.outfitTag = tag
        self.outfitID = outfitID
    }
}

let SAMPLE_OUTFIT:[outfit] = [
    outfit(title:"Date", tag:"dress", outfitID:1),
    outfit(title:"Picnic", tag:"skirt", outfitID:2),
    outfit(title:"School", tag:"pants", outfitID:3)
]

//Outfit ID
//PhotoFile
//Title
//OutfitTag
