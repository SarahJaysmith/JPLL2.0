//
//  UserEditView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-31.
//

import SwiftUI

struct PuzzleAddFormView: View {
    
    @EnvironmentObject var model: AppViewModel
    @EnvironmentObject var networkController: NetworkController
    
    let product: Product
    let productURL: String

    
    @State var asin = ""
    @State var puzzleTitle: String = ""
    @State var manufacturer = ""
    @State var numPieces = "1000"
    @State var puzzleImage = ""
    @State var buttonText = "Save Details"
    @State private var selectedSize = "1000"
    @State private var puzzleAdded = false
    
    
    init(product: Product, productURL: String){

        self.product = product
        self.productURL = productURL

        _asin = State<String>(initialValue: product.asin)
        _puzzleTitle = State<String>(initialValue: product.productTitle)
        _manufacturer = State<String>(initialValue: product.manufacturer)
        _puzzleImage = State<String>(initialValue: product.mainImage["imageUrl"] ?? "")
    }
    
    var sizes = ["500", "1000", "1500", "2000"]
    
    var body: some View {
        
        if !puzzleAdded{
            PageTitleView(title: "Complete Puzzle Details")
        }
        
        
        VStack{
            if !puzzleAdded{
                Form {
                    Group{
                        VStack(alignment: .leading){
                            Text("Title:        ")
                                .bold()
                            Text(product.productTitle)
                                .padding(.bottom, 15)

                            Text("Manufacturer: ")
                                .bold()
                            Text(product.manufacturer)
                        }

                        Picker("Choose the number of pieces:", selection: $selectedSize) {
                                ForEach(sizes, id: \.self) {
                                    Text($0)
                                }
                            }
                        HStack{
                            Spacer()
                            AsyncImage(url: URL(string: product.mainImage["imageUrl"]!)){ image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 250, height: 150)
                            Spacer()
                        }
                    }
                    HStack{
                        Spacer()
                        Button(action:  {
                            model.addPuzzleData(id: product.asin, puzzleTitle: product.productTitle, manufacturer: product.manufacturer, numPieces: selectedSize, puzzleImage: product.mainImage["imageUrl"]!)
                            puzzleAdded = true
                        }, label: {
                            Text(self.buttonText)
                                .bold()
                            .padding(5)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                        })
                        Spacer()
                    }
                }
                }else {
                    Text("Puzzle added!")
                    NavigationLink(destination: HomePageView()) {
                            Text("Continue")
                            .frame(minWidth: 0, maxWidth: 150)
                            .padding(5)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.headline)
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                }
                    Spacer()
            }
        }
        
    }
}

//struct PuzzleAddFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        PuzzleFormView()
//    }
//}

