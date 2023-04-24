//
//  ClosetView.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/11/23.
//
import SwiftUI


struct ClosetView: View {

    @EnvironmentObject var clothingItemManager: ClothingItemManager
    @EnvironmentObject var selectedItemsManager: SelectedItemsManager
    
    @State private var showPopup = false
    @State private var isEditing = false
    
    // Add this line
        @Binding var newClothingItem: String
    
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
                //grid?
                List(clothingItemManager.clothingItems, id: \.ItemTag) { clothingItem in
                    if isEditing {
                        CheckboxRow(clothingItem: clothingItem, selectedItemsManager: selectedItemsManager)
                    } else {
                        Image(uiImage: clothingItem.ImageURL)
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                    }
                }
    
                .navigationTitle("Closet")
                .navigationBarItems(leading: Button(action: {
                        isEditing.toggle()
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
                print(selectedItemsManager.selectedItems) // <-- Print the selected items
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
    @ObservedObject var selectedItemsManager: SelectedItemsManager
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.circle" : "circle")
                .onTapGesture {
                    isChecked.toggle()
                    if isChecked {
                        selectedItemsManager.selectedItems.append(clothingItem)
                    } else {
                        selectedItemsManager.selectedItems.removeAll(where: { $0.ImageURL == clothingItem.ImageURL})
                    }
                }
            Image(uiImage: clothingItem.ImageURL)
                .resizable()
                .frame(width: 200, height: 200)
        }
    }
}


struct ContentofClosetView: View {
    @StateObject var clothingItemManager = ClothingItemManager()
    @StateObject var selectedItemsManager = SelectedItemsManager()

    var body: some View {
        ClosetView()
            .environmentObject(clothingItemManager)
            .environmentObject(selectedItemsManager)
    }
}

struct ContentofCloset_Previews: PreviewProvider {

    static var previews: some View {

        ContentofClosetView()

    }

}
