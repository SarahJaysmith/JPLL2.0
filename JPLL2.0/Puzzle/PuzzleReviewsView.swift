//
//  PuzzleReviewsView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-05.
//

import SwiftUI
import UIKit
import Foundation

struct PuzzleReviewsView: View {
    
    let puzzle: Puzzle
    let productReview: ProductReview
    
    var body: some View {
        VStack (){
            PageTitleView(title: puzzle.puzzleTitle)
            
            if productReview.countReviews > 0{
                Text("\nThere are \(productReview.countReviews) reviews. Click each one to read the full review:")
                CustomDividerView()
                
                ScrollView{
                    ForEach(productReview.reviews, id: \.reviewId) { review in
                        NavigationLink(destination: PuzzleReviewDetailView(rating: review.rating, date: review.date, fullReview: review.text))
                            {
                                VStack(spacing:2){
                                    Text(review.rating)
                                        .bold()
                                    Text(review.date)
                                        .italic()
                                    Text(review.text)
                                }.lineLimit(1)
                                .padding(10)
                            }
                        }
                }
                
                Spacer()
                
            } else {
                Text("Loading reviews...")
                Spacer()
            }
        }
        .padding(2)

    }
}

//struct PuzzleReviewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PuzzleReviewsView()
//    }
//}
