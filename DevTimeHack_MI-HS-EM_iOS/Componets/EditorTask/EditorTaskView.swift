//
//  EditorTaskView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import SwiftUI


fileprivate struct InputRow<ContentView: View>: View {
    let title: String
    let view: () -> ContentView
    
    init(_ title: String, view: @escaping () -> ContentView) {
        self.title = title
        self.view = view
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            view()
        }
    }
}


struct EditorTaskView: View {
    private enum Focus {
        case textEditor
    }
    @EnvironmentObject var store: RootStore
    @State private var orientation: UIInterfaceOrientation = .unknown
    @State private var nameTask = ""
    @State private var deadline: Date = .now
    @State private var textTask = ""
    @FocusState private var focus: Focus?
    
    var body: some View {
        ScrollView {
            VStack {
                InputRow("Name") {
                    TextField("value", text: $nameTask)
                }
                InputRow("Deadline") {
                    DatePicker("", selection: $deadline)
                }
                TextEditorResizingView(text: $textTask, orientation: .portrait, minHeightPortrait: 120, minHeightLandscape: 200)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .background {
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(AppColor.second, lineWidth: 1)
                    }
                    .cornerRadius(16)
                    .overlay(alignment: .topLeading) {
                        if textTask.isEmpty {
                            Text("Write something...")
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                                .padding(.top, 12)
                                .foregroundStyle(AppColor.second)
                        }
                    }
                    .focused($focus, equals: .textEditor)
                    .onTapGesture {
                        focus = .textEditor
                    }
            }
        }.onTapGesture {
            focus = .none
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Ready") {
                    if let taskID = store.state.editortask.taskID {
                        store.dispatch(
                            .editorTask(
                                .updateTask(taskID: taskID, name: nameTask, attendantID: store.state.user?.id ?? 0, deadline: deadline, text: textTask)
                            )
                        )
                    } else {
                        store.dispatch(.editorTask(.createTask(name: nameTask, attendantID: store.state.user?.id ?? 0, deadline: deadline, text: textTask)))
                    }
                }
            }
        }
    }
}

#Preview {
    EditorTaskView()
}
