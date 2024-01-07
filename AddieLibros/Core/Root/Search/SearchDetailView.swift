//
//  SearchDetailView.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import SwiftUI

struct SearchDetailView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var authorViewModel = MainBooksViewModel()
    let book: Docs
    
    var body: some View {
        ZStack{
            VStack {
                ScrollView(.vertical) {
                    Divider()
                    Text("Type of item: \(book.type ?? "")")
                    Divider()
                    let coverUrl = "https://covers.openlibrary.org/b/ID/\(book.coverI ?? -1)-L.jpg"
                    coverRemoteImage(urlString: coverUrl)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 90)
                        .cornerRadius(8)
                    Divider()
                    HStack{
                        Text("Book title: \(book.title ?? "")")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        ZStack{
                            if let key = book.key {
                                VStack{
                                    ZStack{
                                        if viewModel.isFavoriteBook(key: key){
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
                                        viewModel.isFavoriteBook(key: key)
                                        ? viewModel.deleteFromFavoriteList(key: key) : viewModel.addToFavoriteList(key: key)
                                    }
                                }
                            }
                        }
                    }
                    Text("Book title suggestions: \(book.titleSuggest ?? "")")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text("Book title sort: \(book.titleSort ?? "")")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text("Book subtitle: \(book.subtitle ?? "")")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text("Ebook Access: \(book.ebookAccess ?? "")")
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text("Number of pages: \(book.numberOfPagesMedian ?? 0)")
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text("First yearof publication: \(book.firstPublishYear ?? 0)")
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    
                    VStack(alignment: .leading){
                        Text("Publishers: ")
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        VStack(alignment: .center){
                            if let publishers = book.publisher{
                                ForEach(publishers, id:\.self){publisher in
                                    Text(publisher)
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("Languages: ")
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        VStack(alignment: .center){
                            if let languages = book.language{
                                ForEach(languages, id:\.self){language in
                                    Text(language)
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("Authors: ")
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        VStack(alignment: .center){
                            let authorsName = book.authorName
                            if let authorsKey = book.authorKey{
                                ForEach(0..<authorsKey.count, id:\.self){i in
                                    Button(authorsName?[i] ?? ""){
                                        Task{
                                            let authorKeyFormat = "/authors/" + authorsKey[i]
                                            await authorViewModel.getAuthorDetailData(authorKey: authorKeyFormat)
                                        }
                                        authorViewModel.isShowingAuthorDetail = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .disabled(authorViewModel.isShowingAuthorDetail)
            
            if authorViewModel.isShowingAuthorDetail{
                AuthorDetail(
                    isShowingAuthorDetail: $authorViewModel.isShowingAuthorDetail,
                    isShowingSafariView: $authorViewModel.isShowingSafariView,
                    urlString: $authorViewModel.urlString,
                    authorDetailData: $authorViewModel.authorDetailData)
            }
        }
        .alert(item: $viewModel.alertItem){alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

