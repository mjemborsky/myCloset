//
//  ClosetView.swift
//  myCloset
//
//  Created by Ryan Lounsbury on 3/11/23.
//

import SwiftUI

struct ClosetView: View {
    
        @State private var isTopsExpanded = false
        @State private var selectedTops = 1
        @State private var isBottomsExpanded = false
        @State private var selectedBottoms = 1
        @State private var isShoesExpanded = false
        @State private var selectedShoes = 1
        @State private var isAccessoriesExpanded = false
        @State private var selectedAccessories = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Your Closet")
                .font(.largeTitle)
            Text("Tops")
                .font(.title3)
            DisclosureGroup("\(selectedTops)", isExpanded: $isTopsExpanded) {
                ScrollView {
                    VStack {
                        ForEach(1...5, id: \.self) {num in Text("\(num)")
                                .frame(maxWidth: .infinity)
                                .font(.title3)
                                .padding(.all)
                                .onTapGesture {
                                    self.selectedTops = num
                                    withAnimation {
                                        self.isTopsExpanded.toggle()
                                    }
                                }
                        }
                    }
                }.frame(height: 150)
            }.accentColor(.white)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.all,10)
            .background(Color.blue)
            .cornerRadius(8)
            Text("Bottoms")
                .font(.title3)
            DisclosureGroup("\(selectedBottoms)", isExpanded: $isBottomsExpanded) {
                ScrollView {
                    VStack {
                        ForEach(1...5, id: \.self) {num in Text("\(num)")
                                .frame(maxWidth: .infinity)
                                .font(.title3)
                                .padding(.all)
                                .onTapGesture {
                                    self.selectedBottoms = num
                                    withAnimation {
                                        self.isBottomsExpanded.toggle()
                                    }
                                }
                        }
                    }
                }.frame(height: 150)
            }.accentColor(.white)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.all,10)
            .background(Color.blue)
            .cornerRadius(8)
            Text("Shoes")
                .font(.title3)
            DisclosureGroup("\(selectedShoes)", isExpanded: $isShoesExpanded) {
                ScrollView {
                    VStack {
                        ForEach(1...5, id: \.self) {num in Text("\(num)")
                                .frame(maxWidth: .infinity)
                                .font(.title3)
                                .padding(.all)
                                .onTapGesture {
                                    self.selectedShoes = num
                                    withAnimation {
                                        self.isShoesExpanded.toggle()
                                    }
                                }
                        }
                    }
                }.frame(height: 150)
            }.accentColor(.white)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.all,10)
            .background(Color.blue)
            .cornerRadius(8)
            Text("Accessories")
                .font(.title3)
            DisclosureGroup("\(selectedAccessories)", isExpanded: $isAccessoriesExpanded) {
                ScrollView {
                    VStack {
                        ForEach(1...5, id: \.self) {num in Text("\(num)")
                                .frame(maxWidth: .infinity)
                                .font(.title3)
                                .padding(.all)
                                .onTapGesture {
                                    self.selectedAccessories = num
                                    withAnimation {
                                        self.isAccessoriesExpanded.toggle()
                                    }
                                }
                        }
                    }
                }.frame(height: 150)
            }.accentColor(.white)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.all,10)
            .background(Color.blue)
            .cornerRadius(8)
            Spacer()
        }.padding(.all)
    }
}

struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView()
    }
}

