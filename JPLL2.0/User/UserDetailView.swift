//
//  UserDetailView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-30.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    @EnvironmentObject var model: AppViewModel
    @State private var showingPuzzlesSheet = false
    
    var body: some View {
        Text(user.userName)
            .font(.title)
        VStack(alignment: .leading, spacing: 10){
            
            HStack(alignment: .top){
                Text("Location:     ")
                    .bold()
                Text(user.location)
                Spacer()
            }.padding(2)

            HStack(alignment: .top){
                Text("Email:           ")
                    .bold()
                Text("\(user.email)")
                Spacer()
            }.padding(2)
            
            VStack(alignment: .leading, spacing: 5){
                Text("Puzzles:       ")
                        .bold()
                if model.puzzlesOwned.isEmpty && model.puzzlesBorrowed.isEmpty{
                    Text("\(user.firstName) has not added or borrowed any puzzles yet.")
                } else {
                
                    if model.puzzlesOwned.isEmpty{
                        Text("\(user.firstName) does not own any puzzles.")
                    } else {
                        Text("\(user.firstName) owns \(model.puzzlesOwned.count) puzzle(s).")
                    }
                    
                    if model.puzzlesBorrowed.isEmpty{
                        Text("\(user.firstName) has not borrowed any puzzles.")
                    } else {
                        Text("\(user.firstName) has borrowed \(model.puzzlesBorrowed.count) puzzle(s).")
                    }
                    
                    Button(action: {
                        showingPuzzlesSheet.toggle()
                    }, label: {
                        Text("View Puzzles")
                            .bold()
                            .underline()
                        .foregroundColor(.teal)
                        .sheet(isPresented: $showingPuzzlesSheet) {
                            PuzzlesSheetView()
                        }
                    })
                }
 
            }
            .onAppear{
                model.getUserPuzzleData(userID: user.id!, typeOfUser: "owner")
                model.getUserPuzzleData(userID: user.id!, typeOfUser: "borrower")
            }
            
            
//
            if user.id == model.currentUserID {
                // show edit button
                HStack{
                    Spacer()
                        NavigationLink(destination: UserEditFormView(user: user)){
                            Text("Edit Profile")
                                .bold()
                            .frame(minWidth: 0, maxWidth: 150)
                            .padding(5)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                        }
                        .padding(.top, 50)
                    Spacer()
                }
                
            }
            Spacer()
        }.padding()
    }
}

//struct UserDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailView(user: testUser)
//    }
//}
