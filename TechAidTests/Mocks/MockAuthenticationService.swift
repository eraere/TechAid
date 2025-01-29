import Foundation
@testable import TechAid

class MockAuthenticationService {
    var shouldSucceed = true
    
    func signIn(email: String, password: String) async throws -> User {
        if shouldSucceed {
            return User(id: "test_id", name: "Test User")
        } else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
    }
} 