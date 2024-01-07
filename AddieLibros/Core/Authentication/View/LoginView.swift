//
//  LoginView.swift
//  AdaLibros
//
//  Created by cristian regina on 1/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                        AdaImage()
                        
                   VStack(spacing: 24) {
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                            .autocapitalization(.none)
                            .frame(width: 250, height: 30)
                            .background(.white)
                            .padding(.horizontal)
                            .padding(.top, 12)
                        
                        InputView(text: $password, title: "Password",
                                  placeholder: "Enter your Password",
                                  isSecureField: true)
                        .frame(width: 250, height: 30)
                        .background(.white)
                        .padding(.horizontal)
                        .padding(.top, 12)
                        
                        Button{
                            Task{
                                try await viewModel.signIn(withEmail: email, password: password)
                            }
                        }label: {
                            HStack{
                                Text("SIGN IN")
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
                        .padding(.top, 15)
                        
                    }
                    
                    Spacer().frame(height: 80)
                    
                    NavigationLink{
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack{
                            Text("Don'have an account yet?")
                            Text("Sign up")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                    }
                    
                   
                }
                .background(Color.white)
                .cornerRadius(20)
            }
            .background(Image("Background"))
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
