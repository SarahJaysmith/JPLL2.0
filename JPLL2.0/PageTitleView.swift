//
//  PageTitleView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-29.
//

import SwiftUI

struct PageTitleView: View {
    var title: String
    
    var body: some View {
        HStack{
            Spacer()
            Text(title)
                .bold()
            Spacer()
        }
    }
}

struct PageTitleView_Previews: PreviewProvider {
    static var previews: some View {
        PageTitleView(title: "Page Title")
    }
}
