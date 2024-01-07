//
//  FavoriteListView.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import SwiftUI

struct FavoriteListView: View {
    
    @EnvironmentObject var  viewModel: AuthViewModel
    @StateObject var favViewModel: FavoriteViewModel = FavoriteViewModel()
    @State var favoriteList: [String] =  []
    
    var body: some View {
        ZStack{
            NavigationView{
                List(favViewModel.favBooksList, id: \.key){favBook in
                                HStack{
                                    NavigationLink(destination: FavoriteBookDetail(book: favBook)){
                                        Text(favBook.title ?? "")
                                    }
                                    ZStack(alignment: .trailing){
                                        if let key = favBook.key {
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
                                                    self.favoriteList = viewModel.currentUser?.library ?? []
                                                    favViewModel.updateList(key: key)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                }
            }
            .navigationTitle("Favorite Books")
            
            
            if favViewModel.isLoading {
                LoadingView().frame(width: 200, height: 200, alignment: .center)
            }
        }.onAppear{
            self.favoriteList = viewModel.currentUser?.library ?? []
            Task{
                await favViewModel.fetchList(list: favoriteList)
            }
        }
        .alert(item: $viewModel.alertItem){alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}
