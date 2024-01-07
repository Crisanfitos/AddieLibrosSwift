//
//  SearchView.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    @State var query = ""
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    VStack{
                        TextField("Search some books or authors", text: $query)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .autocorrectionDisabled()
                        Button("Search"){
                            viewModel.doSearch(text: query)
                        }
                    }
                    
                    List{
                            if viewModel.searchResult == nil {
                                Text("Nothing to show, try searching something")
                            } else {
                                let q = viewModel.searchResult?.q ?? ""
                                let numFound = viewModel.searchResult?.numFound ?? 0
                                
                                Text("For query \(q) found \(numFound) coincidences")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.black)
                                
                                if let docs = viewModel.searchResult?.docs {
                                    ForEach(docs, id:\.editionKey){book in
                                        NavigationLink(destination: SearchDetailView(book: book)){
                                            VStack(alignment: .leading){
                                                HStack{
                                                    VStack{
                                                        let coverUrl = "https://covers.openlibrary.org/b/ID/\(book.coverI ?? -1)-L.jpg"
                                                        coverRemoteImage(urlString: coverUrl)
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 120, height: 90)
                                                            .cornerRadius(8)
                                                    }
                                                    VStack(alignment: .center){
                                                        Text("\(book.title ?? "")")
                                                        Text("\(book.titleSuggest ?? "" )")
                                                        Text("\(book.subtitle ?? "" )")
                                                        Text("\(book.firstPublishYear ?? 0 )")
                                                    }
                                                }
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
                        
                    }
                }
            }
            
            if viewModel.isLoading{
                LoadingView()
            }
        }
    }
}
