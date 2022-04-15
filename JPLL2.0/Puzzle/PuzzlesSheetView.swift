//
//  PuzzlesSheetView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-14.
//

import SwiftUI

struct PuzzlesSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: AppViewModel
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Text("Close")
                    .bold()
                    .foregroundColor(.teal)
                Image(systemName: "xmark")
                    .foregroundColor(.teal)
            })
            }
            
            if model.puzzlesOwned.count > 0{
                Text("Puzzles owned:")
                    .foregroundColor(.black)
                    .bold()
                
                CustomDividerView()
                
                List(model.puzzlesOwned){ puzzle in
                    VStack{
                        PuzzleThumbnailRowView(puzzle: puzzle)
                    }.onTapGesture {
                        dismiss()
                    }.foregroundColor(.black)
                    CustomDividerView()

                }.listStyle(PlainListStyle())
            }

            if model.puzzlesBorrowed.count > 0{
                Text("Puzzles borrowed:")
                    .foregroundColor(.black)
                    .bold()
                CustomDividerView()
                
                    List(model.puzzlesBorrowed){ puzzle in
                        VStack{
                            PuzzleThumbnailRowView(puzzle: puzzle)
                        }.onTapGesture {
                            dismiss()
                        }.foregroundColor(.black)
                        CustomDividerView()
                    }.listStyle(PlainListStyle())
            }
            
            Spacer()
        }
        .padding(10)

        
    }
}

//struct PuzzlesOwnedSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        PuzzlesSheetView()
//    }
//}
