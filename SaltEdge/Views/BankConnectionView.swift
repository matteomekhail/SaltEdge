import SwiftUI
import SafariServices

struct BankConnectionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var viewModel = BankConnectionViewModel()
    
    var body: some View {
        ZStack {
            AppTheme.backgroundColor.ignoresSafeArea()
            
            VStack(spacing: AppTheme.standardSpacing) {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Text("Connecting to Salt Edge...")
                            .foregroundColor(AppTheme.secondaryText)
                            .padding(.top)
                    }
                } else if let error = viewModel.error {
                    VStack(spacing: 20) {
                        Text("Connection Error")
                            .font(.title)
                            .foregroundColor(AppTheme.destructiveRed)
                        Text(error)
                            .foregroundColor(AppTheme.secondaryText)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            guard let user = authVM.currentUser else { return }
                            Task {
                                await viewModel.initiateConnection(for: user)
                            }
                        }) {
                            Text("Try Again")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.accentPurple)
                                .foregroundColor(.white)
                                .cornerRadius(AppTheme.cornerRadius)
                        }
                    }
                    .padding()
                } else if let url = viewModel.connectUrl {
                    SafariView(url: URL(string: url)!)
                } else {
                    Text("Connect Your Bank")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.textColor)
                    
                    Text("Securely connect your bank account using Salt Edge")
                        .foregroundColor(AppTheme.secondaryText)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        guard let user = authVM.currentUser else { return }
                        Task {
                            await viewModel.initiateConnection(for: user)
                        }
                    }) {
                        Text("Connect Bank Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.accentPurple)
                            .foregroundColor(.white)
                            .cornerRadius(AppTheme.cornerRadius)
                    }
                }
                
                Button(action: { dismiss() }) {
                    Text("Cancel")
                        .foregroundColor(AppTheme.destructiveRed)
                }
            }
            .padding()
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
} 