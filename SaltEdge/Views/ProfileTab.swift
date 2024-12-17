import SwiftUI

struct ProfileTab: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppTheme.largeSpacing) {
                    // Profile Header
                    VStack(spacing: AppTheme.standardSpacing) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(AppTheme.accentPurple)
                            .frame(minWidth: AppTheme.minimumTapArea, minHeight: AppTheme.minimumTapArea)
                        
                        Text(authVM.currentUser?.email ?? "User")
                            .font(.title2.bold())
                            .foregroundColor(AppTheme.textColor)
                    }
                    .padding(.top, AppTheme.largeSpacing)
                    
                    // Profile Info
                    VStack(spacing: AppTheme.standardSpacing) {
                        infoRow(icon: "envelope.fill", title: "Email", value: authVM.currentUser?.email ?? "")
                    }
                    .padding()
                    .background(AppTheme.secondaryBackground)
                    .cornerRadius(AppTheme.cornerRadius)
                    
                    // Actions
                    VStack(spacing: AppTheme.standardSpacing) {
                        actionButton(icon: "gear", title: "Settings", action: {})
                        actionButton(icon: "questionmark.circle", title: "Help", action: {})
                        actionButton(icon: "arrow.right.square", title: "Sign Out", 
                                  color: AppTheme.destructiveRed,
                                  action: { authVM.signOut() })
                    }
                    .padding()
                    .background(AppTheme.secondaryBackground)
                    .cornerRadius(AppTheme.cornerRadius)
                }
                .padding(.horizontal)
            }
            .background(AppTheme.backgroundColor.ignoresSafeArea())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func infoRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: AppTheme.standardSpacing) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.accentPurple)
                .frame(width: AppTheme.minimumTapArea)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(AppTheme.secondaryText)
                Text(value)
                    .font(.body)
                    .foregroundColor(AppTheme.textColor)
            }
            
            Spacer()
        }
        .frame(minHeight: AppTheme.minimumTapArea)
    }
    
    private func actionButton(icon: String, title: String, color: Color = AppTheme.textColor, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: AppTheme.standardSpacing) {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: AppTheme.minimumTapArea)
                
                Text(title)
                    .foregroundColor(color)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(AppTheme.tertiaryText)
            }
        }
        .frame(minHeight: AppTheme.minimumTapArea)
    }
} 
