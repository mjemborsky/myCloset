//
//  ImagePickerUI.swift
//  myCloset
//
//  Created by alexa on 2/22/23.
//

import SwiftUI

struct ImagePickerUI: View {
    
    @State var isPickerShowing = false
    @State var selectedImage = UIImage?
    
    var body: some View {
        
        VStack{

            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
            Button {
                // Show the image picker
                isPickerShowing = true
            }label: {
                Text("Select a Photo")
            }
        }
        .sheet(isPresented: $isPickerShowing,onDismiss: nil) {
            // Image Picker
            ImagePicker(selectedImage: $selectedImage , isPickerShowing: $isPickerShowing)
        }
    }
        
}

struct ImagePickerUI_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerUI()
    }
}
