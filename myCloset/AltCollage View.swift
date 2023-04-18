//
//  AltCollage View.swift
//  myCloset
//
//  Created by Taylor  on 4/9/23.
//

import SwiftUI

struct Grid: Identifiable {
    @EnvironmentObject var clothingItemManager: ClothingItemManager
    var id = UUID()
    let clothingItem: ClothingItem
    var imageUrl: String { clothingItem.ImageURL }
}
class GridViewModel: ObservableObject {
    @Published var currentGrid: Grid?
    @EnvironmentObject var selectedItemsManager: SelectedItemsManager
    @Published var gridItems:
    [Grid] = [] {
        didSet {
            gridItems = selectedItemsManager.selectedItems.map { Grid(clothingItem: $0) }
        }
    }
}
struct DropViewDelegate: DropDelegate {
    
    var grid: Grid
    var gridData: GridViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        let fromIndex = gridData.gridItems.firstIndex { (grid) -> Bool in
            return grid.id == gridData.currentGrid?.id
        } ?? 0
        
        let toIndex = gridData.gridItems.firstIndex { (grid) -> Bool in
            return grid.id == self.grid.id
        } ?? 0
        
        if fromIndex != toIndex{
            withAnimation(.default){
                let fromGrid = gridData.gridItems[fromIndex]
                gridData.gridItems[fromIndex] = gridData.gridItems[toIndex]
                gridData.gridItems[toIndex] = fromGrid
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}
struct altCollageGrid: View {
    
    @StateObject var gridData = GridViewModel()
    @EnvironmentObject var selectedItemsManager: SelectedItemsManager
       
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        NavigationStack {
            VStack{
                    LazyVGrid(columns: columns,spacing: 0, content: {
                        ForEach(gridData.gridItems){ grid in
                            ZStack {
                                Text(grid.imageUrl) // Display the imageUrl
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .shadow(radius: 5)
                            }
                            .frame(height: 150)
                            .cornerRadius(30)
                            .onDrag({
                                gridData.currentGrid = grid
                                return NSItemProvider(object: grid.imageUrl as NSString)
                            })
                            .onDrop(of: [.text], delegate: DropViewDelegate(grid: grid, gridData: gridData))
                        }
                    })
                   
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .environmentObject(selectedItemsManager)
    }
}
struct AltCollage_View: View {
    @EnvironmentObject var selectedItemsManager: SelectedItemsManager
       
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: ClosetView().environmentObject(ClothingItemManager())) {
                        Text("Back").padding()
                            .foregroundColor(.pink)
                    }
                    Spacer()
                    Text("Your Outfit")
                        .font(.title)
                        .foregroundColor(.black)
                    Spacer()
                    NavigationLink(destination: saveOutfitView()) {
                        Text("Save").padding()
                            .foregroundColor(.pink)
                    }
                }
                Spacer()
                altCollageGrid()
                    .environmentObject(selectedItemsManager)
                    .frame(width: 350, height: 500, alignment: .center)
                Spacer()
            }
        }
    }
}

struct collagegrid: View {
    let images = Image(systemName: "photo")
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        LazyVGrid(columns: columns, spacing:0) {
            ForEach(0 ..< 6, id: \.self) {
                index in images
                    .resizable()
                    .scaledToFill()
                    .border(Color.white)
                    .clipped()
                
            }
            .padding(.top, 5)
        }
    }
}

struct AltCollage_View_Previews: PreviewProvider {
    static var previews: some View {
        AltCollage_View()
    }
}
