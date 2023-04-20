//
//  VerifyTag.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/11/23.
//

import Foundation

func verifyTag(tag:String, taggedItem:ClothingItem) -> Bool{
    if tag == taggedItem.ItemTag {
        return true
    } else {
        return false
    }
}
