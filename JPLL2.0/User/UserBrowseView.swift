//
//  UserBrowseView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-30.
//

import SwiftUI

struct UserBrowseView: View {
    
    @ObservedObject var model = AppViewModel()

    init(){
        model.getUserData()
    }
    
    var body: some View {
        VStack{
            
                List(model.users){ user in
                    NavigationLink(destination: UserDetailView(user: user)){
                            UserRowView(user: user)
                    }
                }
                
                .navigationTitle("Browse Users")
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct UserBrowseView_Previews: PreviewProvider {
    static var previews: some View {
        UserBrowseView()
    }
}
