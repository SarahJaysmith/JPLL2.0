//
//  LogInForm.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-03.
//

import SwiftUI

struct LogInFormView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            Form {
                Text("Log In")
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
                        
                        viewModel.LogIn(email: email, password: password)
                        
                    }, label: {
                        Text("Log In")
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
        }
    }
}

struct LogInFormView_Previews: PreviewProvider {
    static var previews: some View {
        LogInFormView(email: "a@b.com", password: "password")
    }
}
