import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.backgroundColor.ignoresSafeArea()
                
                VStack(spacing: AppTheme.standardSpacing) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.textColor)
                    
                    VStack(spacing: 15) {
                        TextField("Email", text: $email)
                            .textFieldStyle(CustomTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    .padding(.horizontal)
                    
                    if let error = authVM.errorMessage {
                        Text(error)
                            .foregroundColor(AppTheme.destructiveRed)
                            .font(.caption)
                    }
                    
                    Button(action: {
                        if isRegistering {
                            authVM.register(email: email, password: password)
                        } else {
                            authVM.login(email: email, password: password)
                        }
                    }) {
                        Text(isRegistering ? "Register" : "Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.accentPurple)
                            .foregroundColor(.white)
                            .cornerRadius(AppTheme.cornerRadius)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        isRegistering.toggle()
                    }) {
                        Text(isRegistering ? "Already have an account? Login" : "Don't have an account? Register")
                            .foregroundColor(AppTheme.accentYellow)
                    }
                }
                .padding()
            }
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(AppTheme.secondaryBackground)
            .cornerRadius(10)
            .foregroundColor(AppTheme.textColor)
    }
} 