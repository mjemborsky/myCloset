//
//  ContentView.swift
//  myCloset
//
//  Created by alexa on 3/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    
    var body: some View {
        
        VStack {
            if selectedImage != nil{
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
                
            Button{
                
                // Show the image picker
                isPickerShowing = true
                
            } label:{
                Text("Select a Photo")
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil){
            // Image picker
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
