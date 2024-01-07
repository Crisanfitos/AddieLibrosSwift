//
//  BookDetail.swift
//  AddieLibros
//
//  Created by alumno on 28/11/23.
//

import SwiftUI

struct BookDetail: View {
    @EnvironmentObject var userViewModel: AuthViewModel
    @StateObject var viewModel = MainBooksViewModel()
    let book: Book

    
    var body: some View {
        let author = book.authors.first!.name
        ZStack{
            VStack{
                coverRemoteImage(urlString: book.cover_url)
                    .aspectRatio(contentMode: .fit)
                    .border(Color.brown, width: 5)
                    .frame(width: 200, height: 230)
                    .cornerRadius(5)
                VStack(alignment: .leading, spacing: 2){
                    HStack{
                        Text("\(book.title)")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        ZStack{
                            VStack{
                                ZStack{
                                    if userViewModel.isFavoriteBook(key: book.key){
                                        Image(systemName: "heart.fill")
                                          .font(.system(size: 32))
                                          .foregroundColor( .red )
                                    } else {
                                        Image(systemName: "heart")
                                          .font(.system(size: 32))
                                          .foregroundColor( .pink)
                                    }
                                    
                                    
                                }
                                .onTapGesture {
                                    userViewModel.isFavoriteBook(key: book.key)
                                    ? userViewModel.deleteFromFavoriteList(key: book.key) : userViewModel.addToFavoriteList(key: book.key)
                                }
                            }
                        }
                    }
                    Text("First year of publish: \(book.first_publish_year)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    HStack{
                        Text("Available to borrow: ")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        availability(available: book.available_to_borrow, size: 10)
                    }
                    HStack{
                        Text("Available to read: ")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        availability(available: book.is_readable, size: 10)
                    }
                    Text("Authors: \(author)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                }
                LazyVStack(spacing: 10){
                    ForEach(book.authors){author in
                        Button{
                            Task{
                                await viewModel.getAuthorDetailData(authorKey: author.key)
                            }
                            viewModel.isShowingAuthorDetail = true
                        } label: {
                            HButton(title: "Know More about \n \(author.name)", width: 200, bColor: Color.brown, fColor: Color.white)
                        }
                    }
                }
            }
            .disabled(viewModel.isShowingAuthorDetail)
            if viewModel.isShowingAuthorDetail {
                AuthorDetail(
                    isShowingAuthorDetail: $viewModel.isShowingAuthorDetail,
                    isShowingSafariView: $viewModel.isShowingSafariView,
                    urlString: $viewModel.urlString,
                    authorDetailData: $viewModel.authorDetailData)
            }
            
        }
        .alert(item: $userViewModel.alertItem){alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

