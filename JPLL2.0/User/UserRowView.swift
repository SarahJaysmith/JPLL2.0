//
//  UserRowView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-30.
//

import SwiftUI

struct UserRowView: View {
    
    var user: User
    
    var body: some View {
        HStack{
            Text("\(user.userName) (\(user.location))")
            Spacer()
        }
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: testUser)
    }
}
