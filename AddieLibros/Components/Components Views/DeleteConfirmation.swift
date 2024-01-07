//
//  DeleteConfirmation.swift
//  AddieLibros
//
//  Created by cristian regina on 17/11/23.
//

import SwiftUI

struct DeleteConfirmation: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    let userId: String
    var body: some View {
        VStack{
            Text("Are you sure?")
            Spacer().frame(height: 10)
            
            HStack{
                Button{
                    viewModel.isShowingDeleteConfirmation = false
                }label: {
                    Text("Cancel")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 100, height: 40)
                }
                
                Button{
                    viewModel.deleteAccount(currentUserID: userId)
                    viewModel.isShowingDeleteConfirmation = false
                }label: {
                    Text("Delete")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 100, height: 40)
                        .foregroundStyle(Color.red)
                }
            }
           
        }
        .frame(width: 250, height: 80)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
    }
}
