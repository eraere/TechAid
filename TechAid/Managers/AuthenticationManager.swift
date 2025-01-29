import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    func signIn(email: String, password: String) {
        // In a real app, you'd validate credentials against a backend
        // For demo purposes, we'll just simulate authentication
        isAuthenticated = true
        currentUser = User(name: "John Doe")
    }
    
    func signOut() {
        isAuthenticated = false
        currentUser = nil
    }
    
    func signInWithFaceID() {
        // Implement Face ID authentication
        isAuthenticated = true
        currentUser = User(name: "John Doe")
    }
} 