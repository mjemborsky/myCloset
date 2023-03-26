//
//  MenuView.swift
//  myCloset
//
//  Created by Michael Emborsky on 3/26/23.
//

import SwiftUI

struct MenuView: View {
    @Binding var isOpen: Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    var bgColor: Color =
              Color(.init(
                      red: 52 / 255,
                      green: 70 / 255,
                      blue: 182 / 255,
                      alpha: 1))
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
                                        MenuLinks()
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
                .foregroundColor(.blue)
        }
        .offset(x: sideBarWidth / 2, y: 50)
        .animation(.default, value: isOpen)
    }
}

// for an individual menu link
struct menuLink: View {
    var icon: String
    var text: String
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 18)
            Text(text)
                .foregroundColor(.white)
                .font(.body)
        }
        .onTapGesture {
            print("Tapped on \(text)")
        }
    }
}

// for putting all the menu links together
struct MenuLinks: View {
    let items: [MainMenuItem] = [
        MainMenuItem(id: UUID(), icon: "house", text: "Home"),
        MainMenuItem(id: UUID(), icon: "magnifyingglass", text: "Search"),
        MainMenuItem(id: UUID(), icon: "door.sliding.left.hand.closed", text: "myCloset"),
        MainMenuItem(id: UUID(), icon: "person.circle.fill", text: "myProfile"),
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(items) { MainMenuItem in
                menuLink(icon: MainMenuItem.icon, text: MainMenuItem.text)
            }
        }
        .padding(.vertical, 14)
        .padding(.leading, 8)
    }
}
