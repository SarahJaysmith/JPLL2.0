//
//  HomePageView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-29.
//

import SwiftUI

struct StartView: View {
    
    var body: some View {
        ContentHeaderView()
        NavigationView{
            VStack(alignment: .center, spacing: 30){
                
                Text("Welcome to the Jigsaw Puzzle Lending Library!")
                    .bold()
                
                    NavigationLink(destination: LoginView()) {
                                        Text("Log In")
                                            .bold()
                                        .frame(minWidth: 0, maxWidth: 150)
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(.teal)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                                }
                    
                    NavigationLink(destination: SignUpView()) {
                                        Text("Sign Up")
                                            .bold()
                                        .frame(minWidth: 0, maxWidth: 150)
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(.teal)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                                }
                
                Image("Boat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 320, height: 320)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                Text("© Sarah Jaysmith, 2022")
                }  .navigationBarTitle("", displayMode: .inline)
                
                }
        
        .accentColor(.black)
        .navigationBarTitle("", displayMode: .inline)

    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
