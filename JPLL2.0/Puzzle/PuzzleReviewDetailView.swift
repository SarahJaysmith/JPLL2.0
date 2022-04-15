//
//  PuzzleReviewDetailView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-07.
//

import SwiftUI

struct PuzzleReviewDetailView: View {
    let rating: String
    let date: String
    let fullReview: String

    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
                Text(rating)
                .bold()
                Text(date)
                .italic()
                Text(fullReview)
                .fixedSize(horizontal: false, vertical: true)
            }
        .padding(15)
        Spacer()
    }
}

struct PuzzleReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleReviewDetailView(rating: "5 stars", date: "April 2022", fullReview: "This is the full review")
    }
}
