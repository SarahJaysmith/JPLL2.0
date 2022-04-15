//
//  PuzzleRowView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-30.
//

import SwiftUI

struct PuzzleRowView: View {
    var puzzle: Puzzle
    
    var body: some View {
        HStack{
            Spacer()
            
            AsyncImage(url: URL(string: puzzle.puzzleImage)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 250, height: 150)
            
            Spacer()
        }
    }
}

struct PuzzleRowView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleRowView(puzzle: testPuzzle)
    }
}
