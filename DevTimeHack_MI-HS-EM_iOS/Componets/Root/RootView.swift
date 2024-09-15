//
//  RootView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import SwiftUI

struct RootView: View {
    enum CurrentView: Hashable {
        case deadlines, groups, newTask, analytics, profle
    }
    
    @State var selectedView: CurrentView = .deadlines
    private var selectedViewColor: Color? {
        switch selectedView {
        case .deadlines:
            return AppColor.error
        default:
            return nil
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedView) {
                Text("deadlines")
                    .tabItem {
                        AppImage.fire
                        Text("Deadlines")
                    }.tag(CurrentView.deadlines)
                Text("groups")
                    .tabItem {
                        AppImage.groups
                        Text("Groups")
                    }.tag(CurrentView.groups)
                EditorTaskView()
                    .tabItem {
                        AppImage.newTask
                        Text("New task")
                    }.tag(CurrentView.newTask)
                Text("analytics")
                    .tabItem {
                        AppImage.analytics
                        Text("Analytics")
                    }.tag(CurrentView.analytics)
                Text("profile")
                    .tabItem {
                        AppImage.profile
                        Text("Profile")
                    }.tag(CurrentView.profle)
            }.tint(selectedView == .deadlines ? AppColor.error : nil)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(createRootStore())
}
