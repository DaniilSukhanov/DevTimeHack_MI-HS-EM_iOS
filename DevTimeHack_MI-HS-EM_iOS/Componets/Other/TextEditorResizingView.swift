//
//  TextEditorResizingView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import SwiftUI

struct TextEditorResizingView: View {
    
    @Binding var text: String
    let orientation: UIInterfaceOrientation
    let minHeightPortrait: CGFloat
    let minHeightLandscape: CGFloat
    @State var textEditorHeight: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .foregroundColor(.clear)
                .padding(.top, 10)
                .padding(.leading, 10)
                .background(GeometryReader { geometryContent in
                    Color.clear.preference(
                        key: ViewHeightKey.self,
                        value: geometryContent.frame(in: .local).size.height
                    )
                })
            
            TextEditor(text: $text)
                .frame(height: max(
                    orientation.isPortrait ? minHeightPortrait : minHeightLandscape,
                    textEditorHeight
                )).padding(10)
        }.onPreferenceChange(ViewHeightKey.self) {
            textEditorHeight = $0
        }
    }
    
}

private struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
