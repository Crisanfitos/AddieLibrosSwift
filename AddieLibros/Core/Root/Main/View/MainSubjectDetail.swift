//
//  MainSubjectDetail.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import SwiftUI

struct MainSubjectDetail: View {
    
    var subjectName: String
    @StateObject var viewModel = MainBooksViewModel()
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                Text(subjectName)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
                    ScrollView(.vertical){
                        ForEach(viewModel.subjectQuery.works){book in
                            NavigationLink(destination: BookDetail(book: book)){
                                VStack(alignment: .center, spacing: 5) {
                                    coverRemoteImage(urlString: book.cover_url)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 90)
                                        .cornerRadius(8)
                                    Text(book.title)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.black)
                                }
                                .frame(width: 250, height: 150)
                                .background(Color.white)
                                .cornerRadius(20)
                                .frame(width: 270, height: 180)
                                .background(Color.brown)
                                .cornerRadius(20)
                            }
                        }
                    }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
            
        }
        .onAppear{
            viewModel.getSubjectDetail(query: subjectName)
        }
    }
}
