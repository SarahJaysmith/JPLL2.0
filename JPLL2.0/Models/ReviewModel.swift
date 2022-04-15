//
//  ReviewModel.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-05.
//

import Foundation

struct ProductReview: Decodable {
    var responseStatus: String = ""
    var responseMessage: String = ""
    var asin: String = ""
    var currentPage: Int = 0
    var sortStrategy: String = ""
    var productTitle: String = "Reviews loading..."
    var countReviews: Int = 0
    var lastPage: Int = 0
    var reviews: [Review] = []
    
}

struct Review: Decodable{
     
    let reviewId: String
    let text: String
    let date: String
    let userName: String
    let rating: String
}



