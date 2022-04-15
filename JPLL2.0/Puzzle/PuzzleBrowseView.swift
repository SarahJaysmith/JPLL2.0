//
//  PuzzleBrowseView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-29.
//

import SwiftUI

struct PuzzleBrowseView: View {
    
    @ObservedObject var model = AppViewModel()

    var showAvailableOnly: Bool
    
    var body: some View {
        VStack{

            if showAvailableOnly == false{
                // show all puzzles
                Text("Browse Puzzles")
                    .font(.headline)

                List(model.puzzles){ item in
                    NavigationLink(destination: PuzzleDetailView(puzzle: item)){
                            PuzzleRowView(puzzle: item)
                    }
                }.listStyle(PlainListStyle())
            } else {
 
                // only show puzzles available to borrow
                Text("Borrow Puzzles")
                    .font(.headline)

                List(model.puzzles){ item in
                    // don't show puzzles owned by the current user
                    if item.ownerID != model.currentUserID{
                        NavigationLink(destination: PuzzleDetailView(puzzle: item)){
                                PuzzleRowView(puzzle: item)
                        }
                    }
                }.listStyle(PlainListStyle())
            }

        }

        .onAppear{
            model.getPuzzleData(showAvailableOnly: showAvailableOnly)
        }

    }

    

}

struct PuzzleBrowseView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleBrowseView(showAvailableOnly: false)
    }
}
