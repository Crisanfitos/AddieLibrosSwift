//
//  MainBooksViewModel.swift
//  AddieLibros
//
//  Created by cristian regina on 23/11/23.
//

import Foundation

class MainBooksViewModel: ObservableObject{
    
    @Published var subjectList: [Subject] = []
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var authorDetailData = AuthorDetailData()
    @Published var urlString = ""
    @Published var isShowingSafariView = false
    @Published var isShowingAuthorDetail = false
    @Published var isShowingMap = false
    @Published var place = ""
    @Published var subjectQuery = Subject()
    
    func getSubjectDetail(query: String) {
        isLoading = true
        
        Task{
            let subResult = try await NetworkManager.shared.getSubject(subject: query, limit: 10)
            DispatchQueue.main.async{
                self.subjectQuery = subResult
            }
        }
        
        isLoading = false
    }
    
    
    func populateSubjectList() async {
        let lista = MockData.realList//obtenerElementosAleatorios(array: MockData.realList, cantidad: 10)
        //print(lista)
        isLoading = true

        DispatchQueue.main.async{
            self.subjectList.removeAll()
        }
        for item in lista {
            Task{
                let newSubject = try await NetworkManager.shared.getSubject(subject: item, limit: 4)
                DispatchQueue.main.async {
                    self.subjectList.append(newSubject)
                }
            }
        }
        isLoading = false
       // print(subjectList)
    }
    
    func obtenerElementosAleatorios(array: [String], cantidad: Int)-> [String] {
        var intRandom: [Int] = []
        var result: [String] = []
        intRandom.removeAll()
        result.removeAll()
        for _ in 0..<cantidad {
            let randomNumber = Int.random(in: 1...array.count)
            intRandom.append(randomNumber)
        }
        for item in 0..<intRandom.count {
            let word = array[item]
            result.append(word)
        }
        return result
    }
    
   /* func obtenerElementosAleatorios(array: [String], cantidad: Int) -> [String] {
        var elementosAleatorios: [String] = []
        var indiceAleatorio: Int
        for _ in 1...cantidad {
            indiceAleatorio = Int.random(in: 1...cantidad)
            elementosAleatorios.append(array[indiceAleatorio])
        }
        return elementosAleatorios
    }*/
    
    func getAuthorDetailData(authorKey: String) async{
        isLoading = true
            Task{
                let newAuthorDetail = try await NetworkManager.shared.getAuthorDetails(authorKey: authorKey)
                DispatchQueue.main.async {
                    self.authorDetailData = newAuthorDetail
                    print(self.authorDetailData)
                }
            }
        isLoading = false
    }
    
    func getWikipediaUrl()-> URL{
        guard let url = URL(string: urlString) else {
            return URL(string: "google.com")!
        }
        return url
    }
}
