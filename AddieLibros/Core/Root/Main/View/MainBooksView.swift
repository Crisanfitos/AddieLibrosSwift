//
//  MainBooksView.swift
//  AddieLibros
//
//  Created by cristian regina on 23/11/23.
//

import SwiftUI

struct MainBooksView: View {
    
    @StateObject var viewModel = MainBooksViewModel()
    
    var body: some View {
        ZStack{
            NavigationView{
                List(viewModel.subjectList){ actualSubject in
                    LazyVStack{
                             SubjectRowView(subject: actualSubject)
                     }
                }
                .navigationTitle("Topics and Themes")
                .refreshable {
                    Task{
                        await viewModel.populateSubjectList()
                    }
                }
            }
            .onAppear{
                Task{
                    await viewModel.populateSubjectList()
                }
            }
            
            
            if viewModel.isLoading {
                LoadingView()
            }

        }
    }
}

#Preview {
    MainBooksView()
}
