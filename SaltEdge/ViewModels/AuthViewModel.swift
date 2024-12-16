import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    private var users: [String: User] = [:]
    private let userDefaultsKey = "currentUser"
    
    init() {
        loadSavedUser()
    }
    
    private func loadSavedUser() {
        if let userData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }
    
    private func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func register(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        
        guard !users.keys.contains(email) else {
            errorMessage = "Email already registered"
            return
        }
        
        let user = User(email: email, password: password)
        users[email] = user
        currentUser = user
        isAuthenticated = true
        errorMessage = nil
        saveUser(user)
    }
    
    func login(email: String, password: String) {
        guard let user = users[email] else {
            errorMessage = "User not found"
            return
        }
        
        guard user.password == password else {
            errorMessage = "Invalid password"
            return
        }
        
        currentUser = user
        isAuthenticated = true
        errorMessage = nil
        saveUser(user)
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
        errorMessage = nil
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
} 