//
//  PuzzleModel.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-29.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

struct Puzzle: Identifiable, Codable{
    @DocumentID var id: String? = ""
    var puzzleTitle: String = ""
    var manufacturer: String = ""
    var numPieces: Int = 0
    var puzzleImage: String = ""
    var ownerID: String = ""
    var borrowerID: String = ""
    
    func createUIImage(imageName: String) -> UIImage{
        
        let puzzleUIImage = UIImage(named: imageName) ?? UIImage(named: "questionmark")
        
        return puzzleUIImage!
    }
}

let testPuzzle = Puzzle(id: "B004UMANQ0", puzzleTitle: "Winter Trio Horses", manufacturer: "Cobble Hill", numPieces: 1000, puzzleImage: "chWinterTrioHorses")

struct PuzzleModel{
    var puzzleCollection:[Puzzle] = [
    Puzzle(id: "B004UMANQ0", puzzleTitle: "Winter Trio Horses", manufacturer: "Cobble Hill", numPieces: 1000, puzzleImage: "chWinterTrioHorses"),
    Puzzle(id: "B01H7RMXXK", puzzleTitle: "Library Cat", manufacturer: "Cobble Hill", numPieces: 1000, puzzleImage: "chLibraryCat"),
    Puzzle(id: "B081G68PZT", puzzleTitle: "Birds of the Season", manufacturer: "Cobble Hill", numPieces: 1000, puzzleImage: "chBirdsSeason")
    ]
}

//struct PuzzleModel{
//    var puzzleCollection:[Puzzle] = [
//    Puzzle(id: "B004UMANQ0", puzzleTitle: "Winter Trio Horses", manufacturer: "Cobble Hill", numPieces: 1000, puzzleImage: UIImage(named: "chWinterTrioHorses")),
//    Puzzle(id: "B01H7RMXXK", puzzleTitle: "Library Cat", manufacturer: "Cobble Hill", numPieces: 1000, puzzleImage: UIImage(named: "chLibraryCat")),
//    Puzzle(id: "B081G68PZT", puzzleTitle: "Birds of the Season", manufacturer: "Cobble Hill", numPieces: 1000, puzzleImage: UIImage(named: "chBirdsSeason"))
//    ]
//}

