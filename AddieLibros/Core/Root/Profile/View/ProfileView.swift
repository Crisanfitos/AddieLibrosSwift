//
//  ProfileView.swift
//  AdaLibros
//
//  Created by cristian regina on 17/11/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            
            ZStack{
                List{
                    Section{
                        HStack{
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 75, height: 75)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text(user.fullName)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            
                            
                        }
                    }
                    
                    Section("General"){
                        
                    }
                    
                    Section("Account"){
                        Button{
                            viewModel.signOut()
                        } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out", tintColor: .red)
                        }
                        Button{
                            viewModel.isShowingDeleteConfirmation = true
                        } label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Delete Account",
                                        tintColor: .red)
                        }
                    }
                }
                .blur(radius: viewModel.isShowingDeleteConfirmation ? 20 : 0)
                
                
                if viewModel.isShowingDeleteConfirmation {
                    DeleteConfirmation(userId: user.id)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
