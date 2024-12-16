import SwiftUI

struct SettingsTab: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section("Account") {
                    Button(action: {
                        authVM.signOut()
                    }) {
                        HStack {
                            Text("Sign Out")
                                .foregroundColor(AppTheme.destructiveRed)
                            Spacer()
                            Image(systemName: "arrow.right.square")
                                .foregroundColor(AppTheme.destructiveRed)
                        }
                    }
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                            .foregroundColor(AppTheme.textColor)
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(AppTheme.secondaryText)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
} 