//
//  User.swift
//  AdaLibros
//
//  Created by cristian regina on 17/11/23.
//

import Foundation

struct User: Identifiable, Codable {
    
    let id: String
    let fullName: String
    let email: String
    let library: [String]
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }else{
            return ""
        }
    }
    
    
}

extension User {
    static var Mock_user = User(id: NSUUID().uuidString, fullName: "Michael Jordan Peterson", email: "example@email.com" , library: [MockData.book1.key, MockData.book2.key])
}
