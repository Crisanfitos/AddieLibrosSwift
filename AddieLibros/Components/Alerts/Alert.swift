//
//  Alert.swift
//  AddieLibros
//
//  Created by cristian regina on 17/11/23.
//
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //MARK: - Favorite Alerts
    static let addedSuccesfully      = AlertItem(title: Text("Book added succesfully to Favorite List"),
                                                 message: Text(""),
                                                 dismissButton: .default(Text("Ok")))
    static let addedError      = AlertItem(title: Text("Book couldn't be added to Favorite List"),
                                                 message: Text(""),
                                                 dismissButton: .default(Text("Ok")))
    static let deletedSuccesfully      = AlertItem(title: Text("Book deleted succesfully from Favorite List"),
                                                 message: Text(""),
                                                 dismissButton: .default(Text("Ok")))
    static let deletedError      = AlertItem(title: Text("Book couldn't be deleted from Favorite List"),
                                                 message: Text(""),
                                                 dismissButton: .default(Text("Ok")))
    //MARK: - Network Alerts
    static let invalidData           = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid Server Data"),
                                              dismissButton: .default(Text("Ok")))
    static let invalidResponse       = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid response from server, contact support"),
                                              dismissButton: .default(Text("Ok")))
    static let invalidURL            = AlertItem(title:Text("Invalid URL request"),
                                              message: Text("Unable to complete url request"),
                                              dismissButton: .default(Text("Ok")))
    static let unableToComplete      = AlertItem(title: Text("Unable to complete request of data"),
                                                 message: Text("Sorry, no data for the moment"),
                                              dismissButton: .default(Text("Ok")))
    
    //MARK: - Account Alerts
    static let invalidForm      = AlertItem(title: Text("Invalid Form"),
                                                 message: Text("Please be sure all your data in the form is correct or is filled out"),
                                              dismissButton: .default(Text("Ok")))
    static let invalidEmail      = AlertItem(title: Text("Invalid Email"),
                                                 message: Text("Please ensure your email is correct"),
                                              dismissButton: .default(Text("Ok")))
    static let userSaveSucces      = AlertItem(title: Text("Profile Saved"),
                                                 message: Text("Your Profile was saved succesfully"),
                                              dismissButton: .default(Text("Ok")))
    static let invalidUserdata      = AlertItem(title: Text("Invalid User Data"),
                                                 message: Text("There was an error saving or retrieving user data"),
                                              dismissButton: .default(Text("Ok")))
     
}
