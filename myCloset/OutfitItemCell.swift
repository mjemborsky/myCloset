//
//  OutfitItemCell.swift
//  myCloset
//
//  Created by Taylor  on 3/15/23.
//

import SwiftUI

struct OutfitItemCell: View {
    
    let clothingItem: ClothingItem
    
    var body: some View {
        VStack {
            Image(systemName:"tshirt.fill")
                .resizable()
            Text(clothingItem.ItemTag)            
        }
    }
}

struct itemforOutfitCell_Previews: PreviewProvider {
    static var previews: some View {
        OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
    }
}

