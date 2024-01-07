//
//  FavoriteViewModel.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import Foundation

class FavoriteViewModel: ObservableObject{
    
    @Published var favBooksList: [FavoriteBook] = []
    @Published var isLoading = false
    
    func updateList(key: String) {
        if let index = favBooksList.firstIndex(where: {$0.key == key}){
            favBooksList.remove(at: index)
        }
    }
    
    func fetchList(list: [String]) async {
        
        isLoading = true
        
        DispatchQueue.main.async{
            self.favBooksList.removeAll()
        }
        if list.count != 0 {
            for id in list {
                Task{
                    let newBook = try await NetworkManager.shared.getFavoriteBookDetails(bookKey: id)
                    DispatchQueue.main.async {
                        self.favBooksList.append(newBook)
                    }
                }
            }
        }
        
        isLoading = false
        
    }
}
