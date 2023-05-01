//
//  MenuView.swift
//  myCloset
//
//  Created by Michael Emborsky on 3/26/23.
//

import SwiftUI


struct MenuView: View {
    @Binding var isOpen: Bool
    @Binding var feedSelected: Bool
    @Binding var searchSelected: Bool
    @Binding var closetSelected: Bool
    @Binding var profileSelected: Bool
    @Binding var hideFeed: Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    var bgColor: Color =
    Color("turquoise")
//        .init(
//        red: 174 / 255,
//        green: 245 / 255,
//        blue: 234 / 255,
//        alpha: 1))
    var secondaryColor: Color =
    Color(.init(
        red: 100 / 255,
        green: 174 / 255,
        blue: 255 / 255,
        alpha: 1))
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(isOpen ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isOpen)
            .onTapGesture {
                isOpen.toggle()
            }
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                bgColor
                MenuChevron
                
                VStack(alignment: .leading, spacing: 20) {
                    Divider()
                    
                    MenuLinks
                    
                    Divider()
                }
                .padding(.top, 80)
                .padding(.horizontal, 40)
                
            }
            .frame(width: sideBarWidth)
            .offset(x: isOpen ? 0 : -sideBarWidth)
            .animation(.default, value: isOpen)
            
            Spacer()
        }
    }
    
    // for putting all the menu links together
    var MenuLinks: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 18)
                Text("Home")
            }
            .onTapGesture {
                isOpen.toggle()
                feedSelected.toggle()
            }
//            HStack {
//                Image(systemName: "magnifyingglass")
//                    .resizable()
//                    .frame(width: 20, height: 20)
//                    .padding(.trailing, 18)
//                Text("Search")
//            }
//            .onTapGesture {
//                isOpen.toggle()
//                searchSelected.toggle()
//                hideFeed.toggle()
//            }
            HStack {
                Image(systemName: "door.sliding.left.hand.closed")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 18)
                Text("myCloset")
            }
            .onTapGesture {
                isOpen.toggle()
                closetSelected.toggle()
                hideFeed.toggle()
                
            }
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 18)
                Text("Profile")
            }
            .onTapGesture {
                isOpen.toggle()
                profileSelected.toggle()
                hideFeed.toggle()
                
            }
        }
        .padding(.vertical, 14)
        .padding(.leading, 8)
    }
    
    var MenuChevron: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(bgColor)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: isOpen ? -18 : -10)
                .onTapGesture {
                    isOpen.toggle()
                }
            
            Image(systemName: "chevron.right")
                .rotationEffect(
                    isOpen ?
                    Angle(degrees: 180) : Angle(degrees: 0))
                .offset(x: isOpen ? -4 : 8)
                .foregroundColor(Color("wb"))
        }
        .offset(x: sideBarWidth / 2, y: 100)
        .animation(.default, value: isOpen)
    }
}
