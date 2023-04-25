
 // AltCollage View.swift
 // myCloset

//  Created by Taylor  on 4/9/23.


import SwiftUI

struct SelectedItemsView: View {
    @EnvironmentObject var selectedItemsManager: SelectedItemsManager

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
                ForEach(selectedItemsManager.selectedItems, id: \.ImageURL) { item in
                    Image(uiImage: item.ImageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                }
            })
        }
        .navigationTitle("Selected Items")
    }
}

struct AltCollageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedItemsView()
            
    }
}
