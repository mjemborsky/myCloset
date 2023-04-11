//
//  ClosetView.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/11/23.
//
import SwiftUI



struct ClosetView: View {

    @EnvironmentObject var clothingItemManager: ClothingItemManager

    @State private var showPopup = false

    

    var body: some View {

        NavigationView {

            List(clothingItemManager.clothingItems, id: \.ItemTag) { clothingItem in (Text(clothingItem.ImageURL))

            }

            .navigationTitle("Closet")

            .navigationBarItems(trailing: Button(action: {

                showPopup.toggle()

            }, label: {

                Image(systemName: "plus")

            }))

            .sheet(isPresented: $showPopup) {

                ContentView()

            }

        }

    }

}







struct ClosetView_Previews: PreviewProvider {

    static var previews: some View {

        ClosetView()

            .environmentObject(ClothingItemManager())

    }

}
