//
//  SignUpFormView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-03.
//

import SwiftUI

struct SignUpFormView: View {
    @State var email = ""
    @State var password = ""
    @State var formSubmitted = false
    @State var pushFinish = false
    
    @State var user: User = User()
    
    @EnvironmentObject var model: AppViewModel
    
    var body: some View {
        VStack(){
            if !formSubmitted{
                Form {
                    Text("Sign Up")
                        .font(.headline)
                    Text("Email: ")
                    TextField("Your email address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    
                    Text("Password: ")
                    SecureField("Your password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            
                            guard !email.isEmpty && !password.isEmpty else {
                                return
                            }
                            
                            model.SignUp(email: email, password: password)
                            user = model.getCurrentUser()
                            formSubmitted = true
                            
                        }, label: {
                            Text("Sign Up")
                            .frame(minWidth: 0, maxWidth: 150)
                            .padding(5)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.headline)
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                        })
                        Spacer()
                    }
            
                }
            } else {
                VStack{
                Text("Welcome! Please finish setting up your account by clicking the button below.")
                
                    HStack{
                        Spacer()
                        Button(action: {
                            user = model.getCurrentUser()
                            pushFinish = true
                        }, label: {
                            Text("Finish sign up")
                                .bold()
                            .frame(minWidth: 0, maxWidth: 150)
                            .padding(5)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.headline)
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                        })
                        Spacer()
                        NavigationLink(destination: UserAddFormView(user: user), isActive: $pushFinish) { EmptyView() }
                    }
                }.padding(20)
            }
                Spacer()
        }
                
         Spacer()
        }
    }



struct SignUpFormView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFormView()
    }
}
