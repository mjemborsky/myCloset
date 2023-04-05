//
//  NewClothingItemView.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/26/23.
//

import SwiftUI

struct NewClothingItemView: View {
    @EnvironmentObject var clothingItemManager: ClothingItemManager
    @State private var newClothingItem = ""
    
    var body: some View {
        VStack {
            TextField("Clothing Item", text:$newClothingItem)
            
            Button {
                clothingItemManager.addClothingItem(newItemPhoto: newClothingItem)
            } label : {
                Text("Save")
            }
        }
        .padding()
    }
}

struct NewClothingItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewClothingItemView()
    }
}
