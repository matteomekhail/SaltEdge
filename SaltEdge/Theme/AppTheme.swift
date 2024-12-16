import SwiftUI

struct AppTheme {
    // Backgrounds
    static let backgroundColor = Color(.systemBackground)
    static let secondaryBackground = Color(.secondarySystemBackground)
    static let tertiaryBackground = Color(.tertiarySystemBackground)
    static let groupedBackground = Color(.systemGroupedBackground)
    
    // Text Colors
    static let textColor = Color(.label)
    static let secondaryText = Color(.secondaryLabel)
    static let tertiaryText = Color(.tertiaryLabel)
    
    // Brand Colors
    static let accentPurple = Color(UIColor(red: 0.5, green: 0.0, blue: 0.9, alpha: 1.0))
    static let accentYellow = Color(UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0))
    
    // Semantic Colors
    static let destructiveRed = Color(.systemRed)
    static let successGreen = Color(.systemGreen)
    
    // Constants
    static let minimumTapArea: CGFloat = 44
    static let standardSpacing: CGFloat = 16
    static let largeSpacing: CGFloat = 24
    static let cornerRadius: CGFloat = 12
} 