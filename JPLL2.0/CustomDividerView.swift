//
//  CustomDividerView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-13.
//

import SwiftUI

struct CustomDividerView: View {
    let color: Color = .teal
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct CustomDividerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDividerView()
    }
}
