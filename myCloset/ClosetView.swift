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
    // Variable for if sidemenu is showing or not
    @State private var toggleMenu: Bool = false
    // Variables for which view will be switched to next (from sidemenu)
    @State private var willMoveToFeed: Bool = false
    @State private var willMoveToSearch: Bool = false
    @State private var willMoveToCloset: Bool = false
    @State private var willMoveToProfile: Bool = false
    // Variable to hide feedview
    @State private var isHidden: Bool = false
    
    
    
    // Variable for if sidemenu is showing or not
    @State private var toggleMenu: Bool = false
    // Variables for which view will be switched to next (from sidemenu)
    @State private var willMoveToFeed: Bool = false
    @State private var willMoveToSearch: Bool = false
    @State private var willMoveToCloset: Bool = false
    @State private var willMoveToProfile: Bool = false
    // Variable to hide feedview
    @State private var isHidden: Bool = false
    
    
    var body: some View {
        ZStack {
            NavigationView {
<<<<<<< HEAD
                List(clothingItemManager.clothingItems, id: \.id) { clothingItem in Text(clothingItem.ItemPhoto)
                }
                .navigationTitle("Closet")
                .navigationBarItems(trailing: Button(action: {
                    showPopup.toggle()
                }, label: {
                    Image(systemName: "plus")
                }))
                .sheet(isPresented: $showPopup) {
                    NewClothingItemView()
                }
=======
                
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
                
>>>>>>> jonahMergeFeed
            }
            MenuView(isOpen: $toggleMenu, feedSelected: $willMoveToFeed, searchSelected: $willMoveToSearch, closetSelected: $willMoveToCloset, profileSelected: $willMoveToProfile, hideFeed: $isHidden)
                .fullScreenCover(isPresented: $willMoveToFeed) {
                    FeedView()
                }
                .fullScreenCover(isPresented: $willMoveToSearch) {
<<<<<<< HEAD
                    SearchView()
=======
                    FeedView()
>>>>>>> jonahMergeFeed
                }
                .fullScreenCover(isPresented: $willMoveToProfile) {
                    profileView()
                }
                .onAppear {
                    returnToView()
                }
<<<<<<< HEAD
        }
    }
    func returnToView() {
        if willMoveToCloset {
            toggleMenu.toggle()
=======
>>>>>>> jonahMergeFeed
        }
        
    }
    func returnToView() {
        if willMoveToCloset {
            toggleMenu.toggle()
            
        }
        
    }
}







struct ClosetView_Previews: PreviewProvider {

    static var previews: some View {

        ClosetView()

            .environmentObject(ClothingItemManager())

    }

}
