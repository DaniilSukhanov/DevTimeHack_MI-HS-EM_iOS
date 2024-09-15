//
//  LoginView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var store: RootStore
    @State var login = ""
    @State var password = ""
    
    private var state: LoginState {
        store.state.loginState
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
                    InputField("login", text: $login, type: .common, isError: state.error != nil)
                    InputField("password", text: $password, type: .secure, isError: state.error != nil)
                }
            }
            
            if !login.isEmpty && !password.isEmpty {
                Button(action: {
                    
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
        }.navigationTitle("Login")
            .padding(.leading, 50)
            .padding(.trailing, 50)
            
        
    }
}

#Preview {
    LoginView()
        .environmentObject(createRootStore())
}

