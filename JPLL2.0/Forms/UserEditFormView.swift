//
//  UserFormView.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-31.
//

import SwiftUI

struct UserEditFormView: View {
    
    @EnvironmentObject var model: AppViewModel
    
    var user: User = User()

    @State var formSubmitted: Bool = false
    
    var userID: String = ""

    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var location: String = "Vancouver" // default
    
    init(user: User){
        self.user = user
        _firstName = State<String>(initialValue: user.firstName)
        _lastName = State<String>(initialValue: user.lastName)
        _location = State<String>(initialValue: user.location)

    }
    
    var body: some View {
        
        if !formSubmitted {
            PageTitleView(title: "Edit Profile")
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
                       // model.completeUserRecord(firstName: firstName, lastName: lastName, location: location)
                        var updatedUser = User()
                        
                        updatedUser.firstName = firstName
                        updatedUser.lastName = lastName
                        updatedUser.location = location
                        updatedUser.id = user.id
                        
                        model.updateUser(userToUpdate: updatedUser)
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
            Text("Profile updated!")
            
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
//struct UserEditFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFormView(editMode: false)
//    }
//}
