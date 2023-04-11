//
//  forgotPassword.swift
//  myCloset
//
//  Created by Jonah Gloss on 4/10/23.
//

import SwiftUI
import Firebase

struct forgotPassword: View {
    @State private var email = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Forgot Password")
                .padding(70)
                .font(.system(size: 30))

            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(10)
                .padding(.bottom, 30)
                .textInputAutocapitalization(.never)

            Button(action: resetPassword) {
                Text("Reset Password")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .cornerRadius(7)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                alertMessage = "Password reset email sent!"
                showAlert = true
            }
        }
    }
}
struct forgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        forgotPassword()
    }
}
