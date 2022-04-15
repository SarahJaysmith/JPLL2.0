//
//  PuzzleUrlFormView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-09.
//

import SwiftUI

struct PuzzleUrlFormView: View {
    @EnvironmentObject private var networkController: NetworkController
    @State var puzzleURL: String = ""
    @State var pushNext = false
    
    var body: some View {
        PageTitleView(title: "Add Puzzle")
        VStack(spacing: 20){
            Text("Please enter the Amazon URL of the puzzle you wish to add:            ")
            TextField("URL", text: $puzzleURL)
                .padding(5)
        }.padding(20)
        

        HStack{
            Spacer()
            Button(action: {
                networkController.getProductInformation(url: puzzleURL, infoType: "product")
                pushNext = true
            }, label: {
                Text("Add Puzzle")
                    .bold()
                .frame(minWidth: 0, maxWidth: 150)
                .padding(5)
                .foregroundColor(.white)
                .background(.teal)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.headline)
                .shadow(color: .black, radius: 5, x: 5, y: 5)
            })
            Spacer()
            NavigationLink(destination: PuzzleAddFormView(product: networkController.product, productURL: puzzleURL), isActive: $pushNext) { EmptyView() }
        }
          


        Spacer()
    }
}


struct PuzzleUrlFormView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleUrlFormView()
    }
}
