//
//  UserModel.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-30.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable{
    @DocumentID var id: String?
    var firstName:  String = "" 
    var lastName:   String = ""
    var email:      String = ""
    var password:   String = ""
    var location:   String = ""
    
    var userName: String {
        return "\(firstName) \(lastName)"
    }
    
}

let testUser: User = User(id: "0", firstName: "Mary", lastName: "Smith", email: "marysmith@hotmail.com", password: "msmith", location: "Vancouver")

let testOwner: User = User(id: "2", firstName: "Jonathan", lastName: "Kelly", email: "jonathankelly@hotmail.com", password: "jkelly", location: "Richmond")

let testBorrower: User = User(id: "1", firstName: "Fiona", lastName: "Jones", email: "fionajones@hotmail.com", password: "fjones", location: "Burnaby")

//
//struct UserModel{
//    var userCollection:[User] = [
//        User(id: "0", firstName: "Mary", lastName: "Smith", email: "marysmith@hotmail.com", password: "msmith", location: "Vancouver"),
//        User(id: "1", firstName: "Fiona", lastName: "Jones", email: "fionajones@hotmail.com", password: "fjones", location: "Burnaby"),
//        User(id: "2", firstName: "Jonathan", lastName: "Kelly", email: "jonathankelly@hotmail.com", password: "jkelly", location: "Richmond")
//    ]
//}
