//
//  SignUpPage.swift
//  myCloset
//
//  Created by Jonah Gloss on 3/20/23.
//

import SwiftUI
import Firebase

struct SignUpPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String? = nil
    @State private var successfulSignIn: String? = nil

    var body: some View {
        VStack {
            Spacer()
            
            Text("Create Account")
                .padding(80)
                .font(.system(size: 30))
            
            TextField("Email", text: $email )
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(10)
                .padding(.bottom, 10)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(10)
                .padding(.bottom, 10)
                .textInputAutocapitalization(.never)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(10)
                .padding(.bottom, 30)
                .textInputAutocapitalization(.never)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }
            
            if let successfulSignIn = successfulSignIn {
                Text(successfulSignIn)
                    .foregroundColor(.blue)
                    .padding(.bottom, 10)
            }
            
            Button(action: {
                if password != confirmPassword {
                    errorMessage = "Passwords do not match!"
                }
                
                else {
                    signup()
                    successfulSignIn = "Account created succesfully!"
                }
                
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .cornerRadius(7)
                
            }
            Spacer()
            .padding(.bottom, 1)
            
        }
        .padding()
        
    }
    
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
        }
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
