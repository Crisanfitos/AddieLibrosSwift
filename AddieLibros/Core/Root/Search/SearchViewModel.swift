//
//  SearchViewModel.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import Foundation

class SearchViewModel: ObservableObject{
    
    @Published var searchResult: SearchResult? = nil
    @Published var isLoading = false
    
    func doSearch(text: String) {
        isLoading = true
        
        Task{
            let result = try await NetworkManager.shared.searchFor(query: text)
            DispatchQueue.main.async{
                self.searchResult = result
            }
        }
        
        isLoading = false
    }
}
