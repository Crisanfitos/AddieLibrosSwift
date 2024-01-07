//
//  AuthViewModel.swift
//  AddieLibros
//
//  Created by cristian regina on 17/11/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isShowingDeleteConfirmation = false
    @Published var alertItem: AlertItem?
    
    init(){
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("failed to log in error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email:String, password: String, fullName: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email, library: [])
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }catch{
            print("error: \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("failed to sign out error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(currentUserID: String){
        Firestore.firestore().collection("users").document(currentUserID).delete()
        Auth.auth().currentUser?.delete()
        signOut()
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
    
    func isFavoriteBook(key: String) -> Bool{
        var isFavorite = false
        if let user = currentUser {
            if !user.library.isEmpty{
                isFavorite = user.library.contains(key)
            }
        }
        return isFavorite
    }
    
    func addToFavoriteList(key: String) {
        var newFavoriteList: [String] = []
        if let user = currentUser {
            newFavoriteList = user.library
            newFavoriteList.append(key)
            let db = Firestore.firestore()
            let user = db.collection("users").document(user.id)
            user.setData(["library" : newFavoriteList], merge: true)
            Task{
                await fetchUser()
                if let newUser = currentUser {
                    if newUser.library.contains(key){
                        alertItem = AlertContext.addedSuccesfully
                    } else {
                        alertItem = AlertContext.addedError
                    }
                }
            }
        }
    }
    
    func deleteFromFavoriteList(key: String) {
        if let user = currentUser {
            let index = user.library.firstIndex(of: key)!
            var newFavoriteList = user.library
            newFavoriteList.remove(at: index)
            let db = Firestore.firestore()
            let user = db.collection("users").document(user.id)
            user.setData(["library" : newFavoriteList], merge: true)
            Task{
                await fetchUser()
                if let newUser = currentUser {
                    if !newUser.library.contains(key){
                        alertItem = AlertContext.deletedSuccesfully
                    } else {
                        alertItem = AlertContext.deletedError
                    }
                }
            }
        }
    }
}
