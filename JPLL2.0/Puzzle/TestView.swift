//
//  TestView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-14.
//

import SwiftUI

struct TestView: View {
    @State var isAction = false
    @State var pushNext = false
    
    var body: some View {
            NavigationView{
                VStack {
                    Button(action: {
                        isAction.toggle()
                    }) {
                        Text("Open Model")
                    }.sheet(isPresented: $isAction, onDismiss: {
                        pushNext.toggle()
                    }) {
                        TestSheetView(isDismissed: isAction)
                    }
                    NavigationLink(destination: HomePageView(), isActive: $pushNext) {
                        EmptyView()
                    }
                }
            }
        }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
