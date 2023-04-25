//
//  ClosetView.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/11/23.
//
import SwiftUI
import FirebaseFirestore

struct ClosetView: View {

    
    
    @State private var showPopup = false
    @State private var isEditing = false
    @State private var showDoneAlert = false
    @State private var willMoveToSelectedItemsView = false

    
    // Variable for if sidemenu is showing or not
    @State private var toggleMenu: Bool = false
    // Variables for which view will be switched to next (from sidemenu)
    @State private var willMoveToFeed: Bool = false
    @State private var willMoveToSearch: Bool = false
    @State private var willMoveToCloset: Bool = false
    @State private var willMoveToProfile: Bool = false
    // Variable to hide feedview
    @State private var isHidden: Bool = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    let items = Array(1...100).map({"image \($0)"})
    
    let layout = [ GridItem(.adaptive(minimum: 100))]
    
    @EnvironmentObject var clothingItemManager: ClothingItemManager
    @EnvironmentObject var selectedItemsManager: SelectedItemsManager
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, content: {
                        //grid?
                        ForEach(clothingItemManager.clothingItems, id: \.ImageURL) { clothingItem in
                            if isEditing {
                                CheckboxRow(clothingItem: clothingItem, selectedItemsManager: selectedItemsManager)
                            } else {
                                
                                Image(uiImage: clothingItem.ImageURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .clipped()
                                    .aspectRatio(1, contentMode: .fit)
                                
                                
                            }
                        }
                    })
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
//        .environmentObject(self.selectedItemsManager)
//        .environmentObject(self.clothingItemManager)

        .onChange(of: isEditing) { newValue in
            if !newValue {
                print(selectedItemsManager.selectedItems)// <-- Print the selected items
                showDoneAlert.toggle()

            }
        }
        .alert("Build Outfit?", isPresented: $showDoneAlert) {
            Button("No", action: {})
            Button("Yes", action: {
               willMoveToSelectedItemsView = true
                
                // Save the selected items to Firebase
//                let selectedItems = selectedItemsManager.selectedItems.map { $0.ImageURL }
//                let db = Firestore.firestore()
//                db.collection("Selected Items").addDocument(data: ["items": selectedItems])
            })
        }
        .fullScreenCover(isPresented: $willMoveToSelectedItemsView){
            saveOutfitView()
            
        }
    }
    func returnToView() {
        if willMoveToCloset {
            toggleMenu.toggle()
            
        }
        
    }
}


struct CheckboxRow: View {
    
    @State var isSelected: Bool = false
    let clothingItem: ClothingItem
    @ObservedObject var selectedItemsManager: SelectedItemsManager
    
    var body: some View {
        Image(uiImage: clothingItem.ImageURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            .border(isSelected ? Color.blue : Color.clear, width: 3)
            .onTapGesture {
                isSelected.toggle()
                if isSelected {
                    selectedItemsManager.selectedItems.append(clothingItem)
                } else {
                    selectedItemsManager.selectedItems.removeAll(where: { $0.ImageURL == clothingItem.ImageURL })
                }
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
