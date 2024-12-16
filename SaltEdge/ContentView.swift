//
//  ContentView.swift
//  SaltEdge
//
//  Created by Matteo Mekhail on 16/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        Group {
            if authVM.isAuthenticated {
                TabView {
                    HomeTab()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    ProfileTab()
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                    
                    SettingsTab()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .tint(AppTheme.accentYellow)
                .environmentObject(authVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}

#Preview {
    ContentView()
}
