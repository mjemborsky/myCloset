//
//  ClosetView.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/11/23.
//
import SwiftUI
import FirebaseFirestore

struct ClosetView: View {

    var userEmail: String
    var users: [UserProfile]
    var posts: [Post]
    
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
    
    let maxSelectionCount = 4
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    let items = Array(1...100).map({"image \($0)"})
    
    let layout = [ GridItem(.adaptive(minimum: 100))]
    
    @EnvironmentObject var clothingItemManager: ClothingItemManager
    @EnvironmentObject var selectedItemsManager: SelectedItemsManager
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical) {
                    Image("bluecloset-title")
                        .resizable()
                    LazyVGrid(columns: columns, content: {
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
                .onChange(of: isEditing) { newValue in
                           if !newValue {
                               if selectedItemsManager.selectedItems.count > maxSelectionCount {
                                   // Display an error alert if the user selected too many items
                                   let message = "Too many items chosen! Select up to four items to build your outfit!"
                                   let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                                   UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                                   
        //                           // Reset the selected items to the first four
                                   selectedItemsManager.selectedItems = Array(selectedItemsManager.selectedItems.prefix(maxSelectionCount))
                                   showDoneAlert.toggle()
                               }
                               print(selectedItemsManager.selectedItems)
                               showDoneAlert.toggle()
                           }
                       }
            }
            MenuView(isOpen: $toggleMenu, feedSelected: $willMoveToFeed, searchSelected: $willMoveToSearch, closetSelected: $willMoveToCloset, profileSelected: $willMoveToProfile, hideFeed: $isHidden)
                .fullScreenCover(isPresented: $willMoveToFeed) {
                    FeedView(userEmail: userEmail)
                }
//                .fullScreenCover(isPresented: $willMoveToSearch) {
//                    SearchView()
//                }
                .fullScreenCover(isPresented: $willMoveToProfile) {
                    if let index = users.firstIndex(where: {$0.email == userEmail}) {
                        profileView(user: users[index], allUsers: users, posts: posts, userEmail: userEmail)
                    }
                }
                .onAppear {
                    returnToView()
                }
        }
        .onAppear {
            selectedItemsManager.selectedItems.removeAll()
        }
//        .environmentObject(self.selectedItemsManager)
//        .environmentObject(self.clothingItemManager)

     
        .alert("Build Outfit?", isPresented: $showDoneAlert) {
            Button("No", action: {})
            Button("Yes", action: {
               willMoveToSelectedItemsView = true
            })
        }
        .fullScreenCover(isPresented: $willMoveToSelectedItemsView){
            saveOutfitView(userEmail: userEmail, allUsers: users, allPosts: posts)
            
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
    let maxSelectionCount = 4
    
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
                    if selectedItemsManager.selectedItems.count > maxSelectionCount {
                        let message = "Too many items chosen! Select up to four items to build your outfit!"
                        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                    }
                    else {
                        selectedItemsManager.selectedItems.append(clothingItem)
                    }
                } else {
                    selectedItemsManager.selectedItems.removeAll(where: { $0.ImageURL == clothingItem.ImageURL })
                }
            }
    }
}

struct ContentofClosetView: View {
    @StateObject var clothingItemManager = ClothingItemManager()
    @StateObject var selectedItemsManager = SelectedItemsManager()
    let gradient = Gradient(colors: [Color(red: 0.09, green: 0.68, blue: 0.78), Color(red: 0.03, green: 0.85, blue: 0.73)])
    var listOfUsers: [UserProfile]
    var listOfPosts: [Post]
    var userEmail: String
    var body: some View {
        ClosetView(userEmail: userEmail, users: listOfUsers, posts: listOfPosts)
            .environmentObject(clothingItemManager)
            .environmentObject(selectedItemsManager)
            

    }
}
//
//struct ContentofCloset_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentofClosetView(userEmail: "michaelemborsky@gmail.com")
//    }
//}
