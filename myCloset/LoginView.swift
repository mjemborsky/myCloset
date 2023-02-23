//
//  LoginView.swift
//  myCloset
//
//  Created by Jonah Gloss on 2/22/23.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Text("myCloset")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(.bottom, 50)
            TextField("Username or email", text: $username )
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(5)
                .padding(.bottom, 10)
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(5)
                .padding(.bottom, 30)
            Button(action: {
                // Handle action
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(5)
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
