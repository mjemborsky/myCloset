//
//  CollageView.swift
//  myCloset
//
//  Created by Taylor  on 3/15/23.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let itemColor: Color
    let handler: () -> Void = {
        print("Tapped Item")
    

    }
   
}


struct MenuContent: View {
    let items: [MenuItem] = [
        MenuItem(text: "Blue Shirt", itemColor: .blue ),
        MenuItem(text: "Yellow Dress", itemColor: .yellow),
        MenuItem(text: "Pink Pants", itemColor: .pink),
        MenuItem(text: "Red Blouse", itemColor: .red),
        MenuItem(text: "Purple Blouse", itemColor: .purple),
        MenuItem(text: "Green Blouse", itemColor: .green),
        MenuItem(text: "Brown Skirt", itemColor: .brown),
        MenuItem(text: "Mint Pants", itemColor: .mint),
        MenuItem(text: "Green Pants", itemColor: .green),
        MenuItem(text: "White Blouse", itemColor: .white),
        MenuItem(text: "Orange Shorts", itemColor: .orange),
        MenuItem(text: "Cyan Dress", itemColor: .cyan)
    ]
    @State private var offset = CGSize.zero
    @State private var selections: [String] = []
    
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 33/225.0, green: 33/225.0, blue: 33/225.0, alpha: 1))
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(items) { item in
                        HStack {
                            Text(item.text)
                                .foregroundColor(.white)
                                .bold()
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 22))
                            Image(systemName: "tshirt")
                                .resizable()
                                .foregroundColor(item.itemColor)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45, height: 45, alignment: .center)
                            Button(action: {
                                let name = item.text
                                self.selections.append(name)
                            }, label: {Text("Add")})
                           
                            }
                        }
                        
                        .onTapGesture {
                            
                            
                        }
                        .padding()
                        
                        
                    }
                    Spacer()
                }
                .padding(.top, 50)
                
                
            }
       
        
    }
        
    
    
}
    
    struct SideMenu: View {
        let width: CGFloat
        let menuOpened: Bool
        let toggleMenu: () -> Void
        
        var body: some View {
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.gray.opacity(0.15))
                .opacity(self.menuOpened ? 1 : 0)
                .onTapGesture {
                    self.toggleMenu()
                }
                
                HStack {
                    MenuContent()
                        .frame(width: width)
                        .offset(x: menuOpened ? 0 : -width)
                    
                    Spacer()
                }
                
            }
        }
    }
    struct CollageGrid: View {
        @Binding var selections: [String]
        var grid: [GridItem] = [
            GridItem(.adaptive(minimum: 3, maximum: 10)),
            GridItem(.adaptive(minimum: 3, maximum: 10))
        ]
        var body: some View {
            if selections.isEmpty{
                Text("No clothing chosen :(")
            }else {
                LazyHGrid(rows: grid, spacing: 50, content: {
                    ForEach(selections, id: \.self) { selection in
                        Text(String(selection)).padding()
                        
                    }})
                
            }
        }
    }
                          
    
    
    struct CollageView: View {
        @State private var selections = [String]()
        @State var menuOpened = false
        var body: some View {
            ZStack {
                if !menuOpened {
                    Button(action: {
                        self.menuOpened.toggle()
                    }, label: {
                        Text("Open Closet")
                            .frame(width: 200, height: 50, alignment: .center)
                        
                    })
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                SideMenu(width: 250,
                         menuOpened: menuOpened,
                         toggleMenu: toggleMenu)
                CollageGrid(selections: $selections)
            }
            .edgesIgnoringSafeArea(.all)
        }
        func toggleMenu() {
            menuOpened.toggle()
        }
        
    }
                            
    struct outfitCollageView_Previews: PreviewProvider {
        static var previews: some View {
            CollageView()
        }
    }

