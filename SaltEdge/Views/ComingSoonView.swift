import SwiftUI

struct ComingSoonView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            AppTheme.backgroundColor.ignoresSafeArea()
            
            VStack(spacing: AppTheme.standardSpacing) {
                Text("Coming Soon")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.textColor)
                
                Text("This feature will be available in a future update.")
                    .foregroundColor(AppTheme.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.accentPurple)
                        .foregroundColor(.white)
                        .cornerRadius(AppTheme.cornerRadius)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
} 