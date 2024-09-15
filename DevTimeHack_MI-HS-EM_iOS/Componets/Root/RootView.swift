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
                        Text("deadlines")
                    }.tag(CurrentView.deadlines)
                Text("groups")
                    .tabItem {
                        AppImage.fire
                        Text("deadlines")
                    }.tag(CurrentView.groups)
                Text("New task")
                    .tabItem {
                        AppImage.fire
                        Text("deadlines")
                    }.tag(CurrentView.newTask)
                Text("analytics")
                    .tabItem {
                        AppImage.fire
                        Text("deadlines")
                    }.tag(CurrentView.analytics)
                Text("profile")
                    .tabItem {
                        AppImage.fire
                        Text("deadlines")
                    }.tag(CurrentView.profle)
            }.tint(selectedView == .deadlines ? AppColor.error : nil)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(createRootStore())
}
