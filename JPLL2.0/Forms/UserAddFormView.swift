//
//  UserAddFormView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-04-13.
//

import SwiftUI

struct UserAddFormView: View {
    
    @EnvironmentObject var model: AppViewModel
    
    let user: User

    @State var formSubmitted: Bool = false
    
    var userID: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var location: String = "Vancouver" // default
    
    var body: some View {
        
        if !formSubmitted {

            PageTitleView(title: "Complete Sign Up")
            Form {
                Group{
                    HStack{
                        Text("First Name: ")
                        TextField("Your first name", text: $firstName)
                        Spacer()
                    }
                    
                    HStack{
                        Text("Last Name: ")
                        TextField("Your last name", text: $lastName)
                        Spacer()
                    }

                    HStack{
                        Text("Location:    ")
                        TextField("Your location", text: $location)
                        Spacer()
                    }
                
                // user can't edit ID / email / password
                }
                HStack{
                    Spacer()
                    Button(action: {
                        model.completeUserRecord(firstName: firstName, lastName: lastName, location: location)
                        formSubmitted = true
                    }, label: {
                        Text("Save Details")
                            .bold()
                            .padding(5)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                    })
                    
                    
                    Spacer()
                }
            }
        } else {
            Text("Sign up complete!")
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
        }
        Spacer()
    }
}
//
//struct UserAddFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFormView(editMode: false)
//    }
//}

