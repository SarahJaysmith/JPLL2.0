//
//  ContentHeaderView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-29.
//

import SwiftUI

struct ContentHeaderView: View {
    var body: some View {
        
        HStack{
            Spacer()
            Image("logoMedium")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 150)
                .padding(5)
            Spacer()
        }
        .background(Color.teal)
        .padding(0)
    }
}

struct ContentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentHeaderView()
    }
}
