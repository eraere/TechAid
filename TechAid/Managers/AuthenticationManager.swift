import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    func signIn(email: String, password: String) async throws -> User {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Simulate authentication
        let user = User(name: "John Doe")
        isAuthenticated = true
        currentUser = user
        return user
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