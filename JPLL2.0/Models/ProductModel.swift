//
//  ProductModel.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-08.
//

import Foundation

struct Product: Decodable {
    
    var productTitle: String = ""
    var manufacturer: String = ""
    var productRating: String = ""
    var asin: String = ""
    var mainImage = ["imageUrl": "testUrl", "imageResolution": "150x150"]

    
    
}



let testProduct = Product(productTitle: "Coral Sea", manufacturer: "Cobble Hill", productRating: "4.3 out of 5 stars", asin: "B07P87ZRJJ", mainImage: ["imageUrl": "https://m.media-amazon.com/images/I/61scbLBNBeL._AC_.jpg", "imageResolution": "500x339"])

let testURL = "https://www.amazon.ca/Cobble-Hill-1000-Piece-Puzzle/dp/B09RC745Q8/"
