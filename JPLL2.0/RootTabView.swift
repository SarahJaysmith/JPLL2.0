//
//  RootTabView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-31.
//

// to be implemented later

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView{
            HomePageView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            PuzzleBrowseView(showAvailableOnly: false)
                .tabItem{
                    Label("Puzzles", systemImage: "puzzlepiece")
                }
            UserBrowseView()
                .tabItem{
                    Label("Users", systemImage: "person")
                }
        }
        .accentColor(.teal) // changes color of selected tab
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
