//
//  HomePageView.swift
//  AddieLibros
//
//  Created by alumno on 20/11/23.
//

import SwiftUI

struct HomeTabView: View {
    
    var body: some View {
        TabView{
            
            MainBooksView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Genres")
                }
            SearchView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoriteListView()
                .tabItem{
                    Image(systemName: "heart.fill")
                    Text("Favorite Books")
                }
            
            ProfileView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Profile")
                }
            /*AppetizerListView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
            
            OrderView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Orders")
                }
             */
        }
        .tint(Color.brown)
   /*     .task {
            do{
                subject = try await NetworkManager().getSubject(subject: "love", limit: "false")
            } catch NWError.invalidURL{
                print("invalid url")
            } catch NWError.invalidDecode{
                print("invalid decode")
            } catch NWError.invalidResponse{
                print("invalid response")
            } catch {
                print("unexpected error")
            }
            
        }
    */
    }
}

#Preview {
    HomeTabView()
}
