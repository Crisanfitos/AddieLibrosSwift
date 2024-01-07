//
//  RegistrationView.swift
//  AdaLibros
//
//  Created by cristian regina on 1/11/23.
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack{
                    Image("AddieLibros")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 170)
                    .cornerRadius(15)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24) {
                    InputView(text: $fullName,
                              title: "Full name",
                              placeholder: "José Juan")
                        .autocapitalization(.none)
                        .frame(width: 250, height: 30)
                        .padding()
                    
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                        .autocapitalization(.none)
                        .frame(width: 250, height: 30)
                        .padding()
                    
                    InputView(text: $password, title: "Password",
                              placeholder: "Enter your Password",
                              isSecureField: true)
                    .frame(width: 250, height: 30)
                    .padding()
                    
                    ZStack(alignment: .trailing){
                        InputView(text: $confirmPassword, title: "Confirm Password",
                                  placeholder: "Confirm your Password",
                                  isSecureField: true)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGray))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                    .frame(width: 250, height: 30)
                    .padding()
                    
                    Button{
                        Task{
                            try await viewModel.createUser(withEmail: email,
                                                           password: password,
                                                           fullName: fullName)
                        }
                    }label: {
                        HStack{
                            Text("REGISTER")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: 260, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding()
                    
                    Button{
                        dismiss()
                    } label: {
                        HStack{
                            Text("Already have an account?")
                            Text("Sign in")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                    }
                    
                }
                
            }
            .background(Color.white)
            .cornerRadius(20)
        }
        .background(Image("Background"))
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
        && confirmPassword == password
    }
}

#Preview {
    RegistrationView()
}
