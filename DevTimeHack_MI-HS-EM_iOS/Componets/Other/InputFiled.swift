//
//  InputFiled.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import SwiftUI


struct InputField: View {
    enum TypeField {
        case common, secure
    }
    enum CurrentFocus: Hashable {
        case textField
    }
    
    @FocusState private var focus: CurrentFocus?
    
    let type: TypeField
    @Binding var text: String
    let prompt: String
    let isError: Bool
    
    init(_ prompt: String, text: Binding<String>, type: TypeField, isError: Bool) {
        self.type = type
        self._text = text
        self.prompt = prompt
        self.isError = isError
    }
    
    var body: some View {
        HStack {
            if type == .common {
                TextField(prompt, text: $text)
                    .focused($focus, equals: .textField)
            } else {
                SecureField(prompt, text: $text)
                    .focused($focus, equals: .textField)
            }
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    AppImage.cancel
                        .foregroundStyle(isError ? AppColor.error : AppColor.first)
                        
                }
            }
        }.padding(.init(top: 18, leading: 16, bottom: 18, trailing: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(isError ? AppColor.error : AppColor.second, lineWidth: 2)
            ).onTapGesture {
                focus = .textField
            }
        
    }
}
