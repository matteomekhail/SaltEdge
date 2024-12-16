import Foundation

struct User: Codable {
    let email: String
    let password: String
    let createdAt: Date
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        self.createdAt = Date()
    }
} 