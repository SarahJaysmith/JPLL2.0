//
//  PuzzleBorrowedView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-11.
//

import SwiftUI

struct PuzzleBorrowedView: View {
    @ObservedObject var model = AppViewModel()
    
    let puzzle: Puzzle
    let borrow: Bool
    
    var body: some View {
        if borrow{
            VStack{
                Text("You have borrowed ") + Text("\(puzzle.puzzleTitle)!").bold()
            }
            .onAppear(perform: {
                model.borrowPuzzle(puzzleToBorrow: puzzle)
            })
            .padding()
        } else {
            VStack{
                Text("You have returned ") + Text("\(puzzle.puzzleTitle)!").bold()
            }
            .onAppear(perform: {
                model.returnPuzzle(puzzleToBorrow: puzzle)
            })
            .padding()
        }
        NavigationLink(destination: HomePageView()){
            Text("Continue")
                .bold()
            .frame(minWidth: 0, maxWidth: 150)
            .padding(5)
            .foregroundColor(.white)
            .background(.teal)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black, radius: 5, x: 5, y: 5)
        }
        }
    }

struct PuzzleBorrowedView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleBorrowedView(puzzle: testPuzzle, borrow: true)
    }
}
