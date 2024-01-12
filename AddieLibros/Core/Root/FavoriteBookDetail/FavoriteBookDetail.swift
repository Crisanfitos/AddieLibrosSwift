//
//  FavoriteBookDetail.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import SwiftUI

struct FavoriteBookDetail: View {
    
    @EnvironmentObject var userViewModel: AuthViewModel
    @StateObject var viewModel = MainBooksViewModel()
    let book: FavoriteBook
    
    var body: some View {
        ZStack{
            NavigationView{
                List{
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack{
                            if let covers = book.covers {
                                ForEach(covers, id: \.self){id in
                                    let coverUrl = "https://covers.openlibrary.org/b/id/\(id)-L.jpg"
                                    coverRemoteImage(urlString: coverUrl)
                                        .aspectRatio(contentMode: .fit)
                                        .border(Color.brown, width: 5)
                                        .frame(width: 200, height: 230)
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }
                    Text(book.key ?? "")
                    
                    HStack{
                        Text(book.title ?? "")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        ZStack{
                            VStack{
                                ZStack{
                                    if userViewModel.isFavoriteBook(key: book.key ?? "" ){
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
                                    userViewModel.isFavoriteBook(key: book.key ?? "")
                                    ? userViewModel.deleteFromFavoriteList(key: book.key ?? "") : userViewModel.addToFavoriteList(key: book.key ?? "")
                                }
                            }
                        }
                    }
                    
                    LazyVStack(spacing: 10){
                        if let authors = book.authors{
                            ForEach(authors){item in
                                let author = item.author
                                Button{
                                    Task{
                                        await viewModel.getAuthorDetailData(authorKey: author?.key ?? "")
                                    }
                                    viewModel.isShowingAuthorDetail = true
                                } label: {
                                    HButton(title: "Know More about \n \(author?.key ?? "")", width: 200, bColor: Color.brown, fColor: Color.white)
                                }
                            }
                        }
                    }
                    ScrollView(.vertical){
                        
                        Text("Know more about this places -->")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        
                        if let places = book.subjectPlaces {
                            ForEach(places, id: \.self){item in
                                Button{
                                    viewModel.place = item
                                    viewModel.isShowingMap = true
                                } label: {
                                    Text(item)
                                }
                            }
                        }
                    }
                }
            }
            .disabled(viewModel.isShowingAuthorDetail || viewModel.isShowingMap)
            if viewModel.isShowingAuthorDetail {
                AuthorDetail(
                    isShowingAuthorDetail: $viewModel.isShowingAuthorDetail,
                    isShowingSafariView: $viewModel.isShowingSafariView,
                    urlString: $viewModel.urlString,
                    authorDetailData: $viewModel.authorDetailData)
            }
            if viewModel.isShowingMap {
                SubjectPlace(
                    place: $viewModel.place,
                    isShowingMap: $viewModel.isShowingMap
                )
            }
        }
        .alert(item: $userViewModel.alertItem){alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}
