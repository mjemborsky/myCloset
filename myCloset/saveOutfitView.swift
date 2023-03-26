//
//  saveOutfitView.swift
//  myCloset
//
//  Created by Taylor  on 3/26/23.
//

import SwiftUI

struct saveOutfitView: View {
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                collage()
                    .navigationTitle("Save Post ")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {}
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink(destination: CollageView()) {
                                Text("Back")
                            }
                        }
                    }
                Spacer()
                NavigationLink(destination: FeedView()) {
                    Text("Post").padding()
                }
            }
        }
    }
}

struct collage: View {
    var body: some View {
        Grid() {
            GridRow {
                OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
                OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
            }
            GridRow {
                OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
                OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
            }
        }
        .frame(width: 350, height: 400)
        
    }
        
    
}

struct saveOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        saveOutfitView()
    }
}
