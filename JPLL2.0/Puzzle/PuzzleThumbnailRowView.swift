//
//  PuzzleThumbnailRowView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-11.
//

import SwiftUI

struct PuzzleThumbnailRowView: View {
    var puzzle: Puzzle
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: puzzle.puzzleImage)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 125, height: 75)
            Text(puzzle.puzzleTitle)
            Spacer()
        }
    }
}

struct PuzzleThumbnailRowView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleThumbnailRowView(puzzle: testPuzzle)
    }
}
