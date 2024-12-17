import SwiftUI

struct HomeTab: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showComingSoon = false
    @State private var showBankConnection = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 25) {
                    welcomeHeader
                    linkBankAccountView
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .sheet(isPresented: $showBankConnection) {
                BankConnectionView()
            }
        }
    }
    
    private var welcomeHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome back,")
                .font(.title3)
                .foregroundColor(AppTheme.secondaryText)
            Text(authVM.currentUser?.email ?? "User")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(AppTheme.accentPurple.opacity(0.2))
        .cornerRadius(15)
    }
    
    private var linkBankAccountView: some View {
        VStack(spacing: 15) {
            Image(systemName: "building.columns.fill")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.accentYellow)
            
            Text("No Bank Account Linked")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.textColor)
            
            Text("Link your bank account to start managing your finances")
                .multilineTextAlignment(.center)
                .foregroundColor(AppTheme.secondaryText)
                .padding(.horizontal)
            
            Button(action: {
                showBankConnection = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Link Bank Account")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppTheme.accentPurple)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.top)
        }
    }
} 
