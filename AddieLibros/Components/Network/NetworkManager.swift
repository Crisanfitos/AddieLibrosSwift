//
//  Network.swift
//  AddieLibros
//
//  Created by cristian regina on 23/11/23.
//

import Foundation
import UIKit
import MapKit


final class NetworkManager {
    private let mapBaseUrl = "http://api.positionstack.com/v1/forward"
    private let apiKey = "d9ff2cb8c8de11518bba8ea4d3a63380"
    
    private let cache = NSCache<NSString, UIImage>()
    static let shared = NetworkManager()
    private let baseURL = "https://openlibrary.org/"
    private let subjectsBaseURL =  "https://openlibrary.org/subjects/"
    private let searchBaseURL = "https://openlibrary.org/search.json?q="

    private init() {}
    
    func searchFor(query: String) async throws -> SearchResult {
        let endPoint = searchBaseURL + query + "&limit=15"
        
        guard let url = URL(string: endPoint) else {
            throw NWError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NWError.invalidResponse
        }
        
        var search = SearchResult()
        
        search = try JSONDecoder().decode(SearchResult.self, from: data)
        
        return search
    }
    
    func getLocation(address: String, delta: Double) async throws -> Address{
        let pAddress = address.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(mapBaseUrl)?access_key=\(apiKey)&query=\(pAddress)"
        guard let url = URL(string: urlString) else{
            throw NWError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NWError.invalidResponse
        }
        
        var addressResult = Address()
        
        do {
            let add = try JSONDecoder().decode(Address.self, from: data)
            let dat = add.data.first ?? Datum()
            addressResult.data.removeAll()
            addressResult.data.append(dat)
            print(addressResult.data)
        } catch {
            throw NWError.invalidDecode
        }
        
        return addressResult
    }
    
    func getAuthorDetails(authorKey: String) async throws -> AuthorDetailData{
        let endpoint = baseURL + authorKey + ".json"
        
        guard let url = URL(string: endpoint) else {
            throw NWError.invalidURL
        }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NWError.invalidResponse
        }
        
        var authorDetail: AuthorDetailData = AuthorDetailData()
        
        do{
            authorDetail = try JSONDecoder().decode(AuthorDetailData.self, from: data)
        }catch {
            let authorDetailWithBioObject = try JSONDecoder().decode(AuthorDetailDataWithBioObject.self, from: data)
            //print(authorDetailWithBioObject)
            authorDetail = AuthorDetailData(
                deathDate: authorDetailWithBioObject.deathDate,
                key: authorDetailWithBioObject.key,
                birthDate: authorDetailWithBioObject.birthDate,
                name: authorDetailWithBioObject.name,
                photos: authorDetailWithBioObject.photos,
                personalName: authorDetailWithBioObject.personalName,
                title: authorDetailWithBioObject.title,
                links: authorDetailWithBioObject.links,
                wikipedia: authorDetailWithBioObject.wikipedia,
                bio: authorDetailWithBioObject.bio?.value)
        }
        
        print("auhtor detail model \(authorDetail)")
        
        return authorDetail
    }
    
    func getFavoriteBookDetails(bookKey: String) async throws -> FavoriteBook{
        let endpoint = baseURL + bookKey + ".json"
        
        guard let url = URL(string: endpoint) else {
            throw NWError.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NWError.invalidResponse
        }
        
        var favoriteBook: FavoriteBook = FavoriteBook()
        
        do{
            favoriteBook = try JSONDecoder().decode(FavoriteBook.self, from: data)
        }catch{
            let favoriteBookWithDescrObject = try JSONDecoder().decode(FavoriteBookWithDescrObject.self, from: data)
            
            favoriteBook = FavoriteBook(title: favoriteBookWithDescrObject.title,
                                        key: favoriteBookWithDescrObject.key,
                                        authors: favoriteBookWithDescrObject.authors,
                                        description: favoriteBookWithDescrObject.description?.value,
                                        covers: favoriteBookWithDescrObject.covers,
                                        subjectPlaces: favoriteBookWithDescrObject.subjectPlaces)
        }
        
        return favoriteBook
    }
    
    func getSubject(subject: String, limit: Int) async throws -> Subject{
        
        let endpoint = subjectsBaseURL + "\(subject).json?details=false&&limit=\(limit)?"
        
        guard let url = URL(string: endpoint) else {
            throw NWError.invalidURL
        }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NWError.invalidResponse
        }
        
            let subject = try JSONDecoder().decode(Subject.self, from: data)
            print("subject model \(subject)")
            return subject
    }
    
    func downloadImage(fromURLString urlString: String)async throws-> UIImage {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: urlString) else {
            throw NWError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NWError.invalidResponse
        }
        cache.setObject(image, forKey: cacheKey)
        return image
    }
}

enum NWError: Error {
    case invalidURL
    case invalidResponse
    case invalidDecode
}
