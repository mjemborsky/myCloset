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
    @State private var isEditing = false
    
    // Variable for if sidemenu is showing or not
    @State private var toggleMenu: Bool = false
    // Variables for which view will be switched to next (from sidemenu)
    @State private var willMoveToFeed: Bool = false
    @State private var willMoveToSearch: Bool = false
    @State private var willMoveToCloset: Bool = false
    @State private var willMoveToProfile: Bool = false
    // Variable to hide feedview
    @State private var isHidden: Bool = false
    
    @State private var selectedItems: [ClothingItem] = []
    
    
    var body: some View {
        ZStack {
            NavigationView {
                List(clothingItemManager.clothingItems, id: \.ItemTag) { clothingItem in
                    if isEditing {
                        CheckboxRow(clothingItem: clothingItem, selectedItems: $selectedItems)
                    } else {
                        (Text(clothingItem.ImageURL))
                    }
                }
            
                
                .navigationTitle("Closet")
                .navigationBarItems(leading: Button(action: {
                        isEditing.toggle() // <-- Toggle editing mode
                }, label: {
                    Text(isEditing ? "Done" : "Select")
                        .padding()
                }), trailing: Button(action: {
                    showPopup.toggle()
                }, label: {
                    Image(systemName: "plus")
                }))
                .sheet(isPresented: $showPopup) {
                    
                    ContentView()
                }
            }
            MenuView(isOpen: $toggleMenu, feedSelected: $willMoveToFeed, searchSelected: $willMoveToSearch, closetSelected: $willMoveToCloset, profileSelected: $willMoveToProfile, hideFeed: $isHidden)
                .fullScreenCover(isPresented: $willMoveToFeed) {
                    FeedView()
                }
                .fullScreenCover(isPresented: $willMoveToSearch) {
                    SearchView()
                }
                .fullScreenCover(isPresented: $willMoveToProfile) {
                    profileView()
                }
                .onAppear {
                    returnToView()
                }
        }
        .onChange(of: isEditing) { newValue in
            if !newValue {
                print(selectedItems) // <-- Print the selected items
            }
        }
        
    }
    func returnToView() {
        if willMoveToCloset {
            toggleMenu.toggle()
            
        }
        
    }
}

struct CheckboxRow: View {
    
    @State var isChecked: Bool = false
    let clothingItem: ClothingItem
    @Binding var selectedItems: [ClothingItem]
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.circle" : "circle")
                .onTapGesture {
                    isChecked.toggle()
                    if isChecked {
                        selectedItems.append(clothingItem)
                    } else {
                        selectedItems.removeAll(where: { $0.ImageURL == clothingItem.ImageURL})
                    }
                }
            Text(clothingItem.ImageURL)
        }
    }
}

struct ContentofClosetView: View {
    @StateObject var clothingItemManager = ClothingItemManager()

    var body: some View {
        ClosetView().environmentObject(clothingItemManager)
    }
}

struct ContentofCloset_Previews: PreviewProvider {

    static var previews: some View {

        ContentofClosetView()

    }

}
