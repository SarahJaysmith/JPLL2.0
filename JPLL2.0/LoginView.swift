//
//  LoginView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-31.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {

    @EnvironmentObject var model: AppViewModel
    @State var pushLogin: Bool = false
    
    var body: some View {
        VStack{

            if model.signedIn{
                VStack(alignment: .center, spacing: 30){
                    Text(model.greeting)
                        .bold()
                    
                    NavigationLink(destination: HomePageView()){
                        Text("Continue")
                            .bold()
                        .frame(minWidth: 0, maxWidth: 150)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(.teal)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                    }
                    VStack{
                        Button(action: {
                            model.LogOut()
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
                }.padding()
            } else {
                VStack{
                    LogInFormView()
                    Spacer()
                }
            }
        }
        Spacer()
        .onAppear{
            model.signedIn = model.isSignedIn
            if model.signedIn{
                model.getSingleUserData(userID: model.currentUserID, typeOfUser: "current")
            }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//            .environmentObject(AppViewModel())
//    }
//}

