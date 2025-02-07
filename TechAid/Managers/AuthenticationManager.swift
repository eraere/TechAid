import SwiftUI
import FirebaseAuth      // Ensure FirebaseAuth is added via SPM or CocoaPods
import FirebaseFirestore // Ensure FirebaseFirestore is added

// Do not duplicate the User declaration here if it's defined elsewhere (e.g. in Models/User.swift).

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    var currentUser: User? // Assume that User is defined exactly once in your project

    init() {
        // Perform any required startup configuration.
    }

    func signIn(email: String, password: String) async throws -> User {
        // Replace this simulated sign in with Firebase's actual async API if available.
        try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate delay
        let user = User(name: "John Doe") // This uses the externally defined User initializer.
        isAuthenticated = true
        currentUser = user
        return user
    }
    
    func signOut() {
        // Sign out from Firebase Auth as needed:
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            currentUser = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func signInWithFaceID() {
        // Implement Face ID authentication as needed.
        isAuthenticated = true
        currentUser = User(name: "John Doe")
    }
    
    // Function to register users via Firebase Authentication.
    // Note: Ensure that the external User type supports this initializer.
    func registerUser(email: String, password: String, fullName: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authUser = authResult?.user {
                // Use only the id and fullName in the User initializer.
                let user = User(id: authUser.uid, name: fullName)
                self.currentUser = user
                self.isAuthenticated = true
                completion(.success(user))
            }
        }
    }
    
    // Helper function to create a Firestore record for the user.
    private func createUserRecord(firebaseUser: FirebaseAuth.User, fullName: String) {
        let db = Firestore.firestore()
        db.collection("users").document(firebaseUser.uid).setData([
            "name": fullName,
            "email": firebaseUser.email ?? "",
            "createdAt": FieldValue.serverTimestamp()
        ]) { error in
            if let error = error {
                print("Error creating user record: \(error.localizedDescription)")
            } else {
                print("User record created successfully")
            }
        }
    }
} 
