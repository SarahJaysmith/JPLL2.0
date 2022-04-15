//
//  HomePageView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-31.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject var model: AppViewModel
    @State var pushProfile: Bool = false
    @State var pushLogin: Bool = false
    
    @State var user:User = User()
        
    var body: some View {
       // NavigationView{

            VStack(alignment: .center, spacing: 30){
                NavigationLink(destination: PuzzleBrowseView(showAvailableOnly: false)) {
                                    Text("Browse Puzzles")
                                    .frame(minWidth: 0, maxWidth: 150)
                                    .padding(5)
                                    .foregroundColor(.white)
                                    .background(.teal)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .font(.headline)
                                    .shadow(color: .black, radius: 5, x: 5, y: 5)
                            }
                
                NavigationLink(destination: PuzzleBrowseView(showAvailableOnly: true)) {
                                    Text("Borrow Puzzles")
                                    .frame(minWidth: 0, maxWidth: 150)
                                    .padding(5)
                                    .foregroundColor(.white)
                                    .background(.teal)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .font(.headline)
                                    .shadow(color: .black, radius: 5, x: 5, y: 5)
                            }
                
                NavigationLink(destination: PuzzleUrlFormView()) {
                                    Text("Add Puzzle")
                                    .frame(minWidth: 0, maxWidth: 150)
                                    .padding(5)
                                    .foregroundColor(.white)
                                    .background(.teal)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .font(.headline)
                                    .shadow(color: .black, radius: 5, x: 5, y: 5)
                            }
                
                NavigationLink(destination: UserBrowseView()) {
                                    Text("Browse Users")
                                    .frame(minWidth: 0, maxWidth: 150)
                                    .padding(5)
                                    .foregroundColor(.white)
                                    .background(.teal)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .font(.headline)
                                    .shadow(color: .black, radius: 5, x: 5, y: 5)
                            }
                
                

                VStack{
                Button(action: {
                    
                    user = model.getCurrentUser()
                    pushProfile = true
                }, label: {
                    Text("My Profile")
                        .bold()
                    .frame(minWidth: 0, maxWidth: 150)
                    .padding(5)
                    .foregroundColor(.white)
                    .background(.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black, radius: 5, x: 5, y: 5)
                })
                 NavigationLink(destination: UserDetailView(user: user), isActive: $pushProfile) { EmptyView() }
                }
                
                VStack{
                    Button(action: {
                        
                        model.LogOut()
                        pushLogin = true
                        
                    }, label: {
                        Text("Log Out")
                            .bold()
                        .frame(minWidth: 0, maxWidth: 150)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(.teal)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                    })
                    NavigationLink(destination: LoginView(), isActive: $pushLogin) { EmptyView() }
                }
                
                Spacer()

                }
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
