//
//  RegistrationView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var store: RootStore
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    var body: some View {
        VStack {
            TextField("username", text: $username)
            TextField("email", text: $email)
            SecureField("password", text: $password)
            SecureField("repeatPassword", text: $repeatPassword)
            Button("go") {
                store.dispatch(
                    .registration(
                        .send(
                            username: username,
                            email: email,
                            password: password,
                            repeatPassword: repeatPassword
                        )
                    )
                )
            }
        }
    }
}

#Preview {
    RegistrationView()
}
// 5G63&dkfldd
