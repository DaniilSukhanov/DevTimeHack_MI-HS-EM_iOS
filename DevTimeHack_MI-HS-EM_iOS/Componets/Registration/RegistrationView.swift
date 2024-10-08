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
    
    private var state: RegistrationState {
        store.state.registrationState
    }
    
    var body: some View {
        VStack {
            VStack {
                if let error = state.error {
                    VStack(spacing: 0) {
                        Text(error)
                            .foregroundStyle(AppColor.error)
                        Spacer(minLength: 48)
                    }
                }
                VStack(spacing: 25) {
                    InputField("username", text: $username, type: .common, isError: state.error != nil)
                    InputField("email", text: $email, type: .common, isError: state.error != nil)
                    InputField("password", text: $password, type: .secure, isError: state.error != nil)
                    InputField("repeat password", text: $repeatPassword, type: .secure, isError: state.error != nil)
                }
            }
            
            if !email.isEmpty && !username.isEmpty && !password.isEmpty && !repeatPassword.isEmpty {
                Button(action: {
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
                }) {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(state.error == nil ? AppColor.first : AppColor.error)
                        .frame(maxHeight: 58)
                        .overlay {
                            Text("GO")
                                .foregroundStyle(AppColor.background)
                        }
                }
            }
        }.navigationTitle("Registration")
            .padding(.leading, 50)
            .padding(.trailing, 50)
            
        
    }
}

#Preview {
    RegistrationView()
        .environmentObject(createRootStore())
}
