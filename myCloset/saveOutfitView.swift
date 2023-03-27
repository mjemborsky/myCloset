//
//  saveOutfitView.swift
//  myCloset
//
//  Created by Taylor  on 3/26/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct saveOutfitView: View {
    @State var title: String = ""
    @State var titles: [String] = []
    @State var tag: String = ""
    @State var tags: [String] = []
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                collage()
                    .navigationTitle("Save Post ")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                saveoutfit()
                            }) {
                                Text("Save")
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink(destination: CollageView()) {
                                Text("Back")
                            }
                        }
                    }
                Spacer()
                TextField("Enter Outfit Title", text: $title)
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                TextField("Enter one or more Outfit Tags", text: $tag)
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                NavigationLink(destination: FeedView()) {
                    Text("Post").padding()
                }
            }
        }
    }
    func saveoutfit() {
          let db = Firestore.firestore()
        let outfitid = UUID().uuidString
        db.collection("Saved Collages").document(outfitid).setData([
            "title": title,
            "tag": tag
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }else {
                print("Document successfully written!")
            }
              
            }
        }
}

    
        
    
    


struct collage: View {
    var body: some View {
        Grid() {
            GridRow {
                OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
                OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
            }
            GridRow {
                OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
                OutfitItemCell(clothingItem: SAMPLE_ITEM[0])
            }
        }
        .frame(width: 350, height: 400)
        
    }
        
    
}

struct saveOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        saveOutfitView()
    }
}
