//
//  AppViewModel.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-06.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var puzzles = [Puzzle]()
    @Published var users = [User]()
    @Published var currentUser: User = User()
    @Published var owner: User = User()
    @Published var borrower = User()
    @Published var puzzlesOwned = [Puzzle]()
    @Published var puzzlesBorrowed = [Puzzle]()
    @Published var currentPuzzle = Puzzle()
    
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    var currentUserID: String {
        return auth.currentUser?.uid ?? "" // user must be logged in to access app, so can't be nil
    }
    
    var currentUserFirstName: String {
        return currentUser.firstName
    }
    
    var greeting: String{
        let welcome = "Welcome, \(currentUser.firstName)!"
        return welcome
    }
    
    
    // login functions
    func LogIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // user has logged in
            DispatchQueue.main.async {
                self?.signedIn = true
                self!.getSingleUserData(userID: self!.auth.currentUser!.uid, typeOfUser: "current")
            }
        }
    }
    
    func LogOut(){
        do {
            try auth.signOut()
            DispatchQueue.main.async {
                self.signedIn = false
                self.currentUser = User()
            }
            
        } catch let error {
            print("Error: ", error.localizedDescription)
        }
    }
    
    func SignUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                print(error!)
                return
            }
            // user has signed up
            DispatchQueue.main.async {
                self?.signedIn = true
                self?.createUserRecord(email: email, password: password, userID: self?.auth.currentUser?.uid ?? "Default")
            }
        }
    }
    
    // database functions
    // users
    func createUserRecord(email: String, password: String, userID: String){
        let db = Firestore.firestore()
        let docData: [String: Any] = [
            "firstName":"","lastName":"","location":"","email":email, "password":password]

        db.collection("users").document(userID).setData(docData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
        }
    }
    
    func completeUserRecord(firstName: String, lastName: String, location: String){
        let db = Firestore.firestore()
        let docData: [String: Any] = [
            "firstName": firstName, "lastName":lastName, "location": location]
        db.collection("users").document(auth.currentUser!.uid).setData(docData, merge: true) { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
        }
    }
    
    func getCurrentUser()->User{
        if auth.currentUser?.uid != nil{
            getSingleUserData(userID: auth.currentUser!.uid, typeOfUser: "current")
        }
        return self.currentUser
    }
    
    func getSingleUserData(userID: String, typeOfUser: String){
        // given a user ID, retrieve the single record
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument(as: User.self) { result in
            switch result {
                case .success(let user):
                    // A `User` value was successfully initialized from the DocumentSnapshot.
                if typeOfUser == "owner"{
                    self.owner = user
                } else if typeOfUser == "borrower"{
                    self.borrower = user
                } else {
                    self.currentUser = user
                }
                
                case .failure(let error):
                    // A `User` value could not be initialized from the DocumentSnapshot.
                    print("Error decoding user: \(error)")
                }
        }
        
    }
    
    func updateUser(userToUpdate: User){

        let db = Firestore.firestore()
        db.collection("users").document(userToUpdate.id!).setData([
            "firstName" : userToUpdate.firstName,
            "lastName" : userToUpdate.lastName,
            "location" : userToUpdate.location
        ], merge: true)
    }
    
    
    func getUserData(){
        
        let db = Firestore.firestore()
        db.collection("users").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.users = snapshot.documents.map { document in
                            return User(
                                id: document.documentID,
                                firstName: document["firstName"] as? String ?? "",
                                lastName: document["lastName"] as? String ?? "",
                                email: document["email"] as? String ?? "",
                                password: document["password"] as? String ?? "",
                                location: document["location"] as? String ?? "")
                        }
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    // puzzles
    func getPuzzleData(showAvailableOnly: Bool){
        
        let db = Firestore.firestore()
        var docRef = db.collection("puzzles")
            .whereField("borrowerID", isEqualTo: "")
        
        if !showAvailableOnly{
            docRef = db.collection("puzzles")
        }
        
        docRef.getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.puzzles = snapshot.documents.map { document in
                            return Puzzle(
                                id: document.documentID,
                                puzzleTitle: document["puzzleTitle"] as? String ?? "",
                                manufacturer: document["manufacturer"] as? String ?? "",
                                numPieces: document["puzzleTitle"] as? Int ?? 1000,
                                puzzleImage: document["puzzleImage"] as? String ?? "",
                                ownerID: document["ownerID"] as? String ?? "",
                                borrowerID: document["borrowerID"] as? String ?? ""
                                )
                            }
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    func getUserPuzzleData(userID: String, typeOfUser: String){
        // fetch the puzzle that a user owns or has borrowed
        let db = Firestore.firestore()
        let typeOfUserID = typeOfUser + "ID"
        //var puzzleResults = [Puzzle]()
        
        db.collection("puzzles").whereField(typeOfUserID, isEqualTo: userID).getDocuments { snapshot, error in

            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        if typeOfUser == "owner"{
                            self.puzzlesOwned = snapshot.documents.map { document in
                                return Puzzle(
                                    id: document.documentID,
                                    puzzleTitle: document["puzzleTitle"] as? String ?? "",
                                    manufacturer: document["manufacturer"] as? String ?? "",
                                    numPieces: document["puzzleTitle"] as? Int ?? 1000,
                                    puzzleImage: document["puzzleImage"] as? String ?? "",
                                    ownerID: document["ownerID"] as? String ?? "",
                                    borrowerID: document["borrowerID"] as? String ?? ""
                                    )
                                }
                        } else {
                            self.puzzlesBorrowed = snapshot.documents.map { document in
                                return Puzzle(
                                    id: document.documentID,
                                    puzzleTitle: document["puzzleTitle"] as? String ?? "",
                                    manufacturer: document["manufacturer"] as? String ?? "",
                                    numPieces: document["puzzleTitle"] as? Int ?? 1000,
                                    puzzleImage: document["puzzleImage"] as? String ?? "",
                                    ownerID: document["ownerID"] as? String ?? "",
                                    borrowerID: document["borrowerID"] as? String ?? ""
                                    )
                                }
                        }
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
        func getSinglePuzzleData(id: String){
            // given a puzzle ID, retrieve the single record
            let db = Firestore.firestore()
            db.collection("puzzles").document(id).getDocument(as: Puzzle.self) { result in
                switch result {
                    case .success(let puzzle):
                        // A `puzzle` value was successfully initialized from the DocumentSnapshot.
                        self.currentPuzzle = puzzle
                    
                    case .failure(let error):
                        // A `puzzle` value could not be initialized from the DocumentSnapshot.
                        print("Error decoding puzzle: \(error)")
                    }
            }
            
        }
    
    func addPuzzleData(id: String, puzzleTitle: String, manufacturer: String, numPieces: String, puzzleImage: String){
        
        let numPiecesInt = Int(numPieces) // we know this parse will work because it comes from a picker
        let ownerID = auth.currentUser?.uid // the currently logged in user is the puzzle owner
        let borrowerID = "" // no borrower initially
        
        let db = Firestore.firestore()
        let docData: [String: Any] = [
            "puzzleTitle":puzzleTitle, "manufacturer":manufacturer, "numPieces":numPiecesInt!, "puzzleImage":puzzleImage, "ownerID":ownerID!, "borrowerID": borrowerID]
        
        db.collection("puzzles").document(id).setData(docData){ error in
            if error == nil{
                self.getPuzzleData(showAvailableOnly: false) // update the UI TODO - not sure we need this!
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func updatePuzzleData(puzzleToUpdate: Puzzle){
        let db = Firestore.firestore()
        db.collection("puzzles").document(puzzleToUpdate.id!).setData([
            "puzzleTitle" : puzzleToUpdate.puzzleTitle,
            "manufacturer" : puzzleToUpdate.manufacturer,
            "numPieces" : puzzleToUpdate.numPieces,
            "puzzleImage" : puzzleToUpdate.puzzleImage
        ])
    }
    
// To be implemented later
//    func deletePuzzleData(puzzleToDelete: Puzzle){
//        let db = Firestore.firestore()
//
//        DispatchQueue.main.async {
//            db.collection("puzzles").document(puzzleToDelete.id!).delete { error in
//                if error == nil{
//                    self.puzzles.removeAll{ puzzle in
//                        return puzzleToDelete.id == puzzle.id
//                    }
//                }
//            }
//        }
//    }
    
    func borrowPuzzle(puzzleToBorrow: Puzzle){
        let db = Firestore.firestore()
        let borrowerID = auth.currentUser!.uid
        db.collection("puzzles").document(puzzleToBorrow.id!).setData([
            "borrowerID" : borrowerID
            
        ], merge: true)
    }
    
    func returnPuzzle(puzzleToBorrow: Puzzle){
        let db = Firestore.firestore()
        let borrowerID = ""
        db.collection("puzzles").document(puzzleToBorrow.id!).setData([
            "borrowerID" : borrowerID
        ], merge: true)
    }
}
