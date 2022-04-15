//
//  PuzzleDetailView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-29.
//

import SwiftUI

struct PuzzleDetailView: View {

    var puzzle: Puzzle
    @State var test: String = ""
    @ObservedObject var model = AppViewModel()
    @EnvironmentObject private var networkController: NetworkController
    
    
    var body: some View {
        PageTitleView(title: puzzle.puzzleTitle)
        VStack(alignment: .center){

                        
            AsyncImage(url: URL(string: puzzle.puzzleImage)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 250, height: 150)
            
            HStack(alignment: .top){
                Text("Manufacturer: ")
                Text("\(puzzle.manufacturer)")
                Spacer()
            }.padding(2)
            
            HStack(){
                Text("Pieces:             ")
                Text("\(puzzle.numPieces)")
                Spacer()
            }.padding(2)
            
            
            NavigationLink(destination: UserDetailView(user: model.owner)){
                HStack(){
                    Text("Owned by:        ").foregroundColor(.black) + Text(model.owner.userName).bold()
                    Spacer()
                }
            }
            .onAppear{
                model.getSingleUserData(userID: puzzle.ownerID, typeOfUser: "owner")
            }
            .padding(5)
            .accentColor(.teal)
            
            if !puzzle.borrowerID.isEmpty{
            // only display this if the puzzle is currently borrowed by someone
                
                    NavigationLink(destination: UserDetailView(user: model.borrower)){
                        HStack(){
                            Text("Borrowed by:    ").foregroundColor(.black) + Text(model.borrower.userName).bold()
                            Spacer()
                        }
                    }
                    .onAppear{
                        model.getSingleUserData(userID: puzzle.borrowerID, typeOfUser: "borrower")
                    }
                    .padding(5)
                    .accentColor(.teal)
                // if current user has borrowed this puzzle, offer them a return puzzle option
                if puzzle.borrowerID == model.currentUserID{
                    NavigationLink(destination: PuzzleBorrowedView(puzzle: puzzle, borrow: false)) {
                                        Text("Return Puzzle")
                                        .frame(minWidth: 0, maxWidth: 150)
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(.teal)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .font(.headline)
                                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                                }
                }
                
                
            } else {
                // puzzle is available, so user can request to borrow it - but only if the current user is not the owner
                if puzzle.ownerID != model.currentUserID{
                    NavigationLink(destination: PuzzleBorrowedView(puzzle: puzzle, borrow: true)) {
                                        Text("Borrow Puzzle")
                                        .frame(minWidth: 0, maxWidth: 150)
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(.teal)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .font(.headline)
                                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                                }
                }
            }
            
            HStack(alignment: .top){
                NavigationLink(destination: PuzzleReviewsView(puzzle: puzzle, productReview: networkController.productReview)) {
                                Text("See Reviews")
                                .frame(minWidth: 0, maxWidth: 150)
                                .padding(5)
                                .foregroundColor(.white)
                                .background(.teal)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .font(.headline)
                                .shadow(color: .black, radius: 5, x: 5, y: 5)
                        }
                        .onAppear{
                            networkController.getProductInformation(url: "https://axesso-axesso-amazon-data-service-v1.p.rapidapi.com/amz/amazon-lookup-reviews?page=1&domainCode=ca&asin=\(puzzle.id!)&sortBy=recent&filters=reviewerType%3Davp_only_reviews%3BfilterByStar%3Dfive_star", infoType: "review")
                        }
            }.padding(2)
            
            Spacer()
        }
        .padding()
    }
}

struct PuzzleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleDetailView(puzzle: testPuzzle)
    }
}
