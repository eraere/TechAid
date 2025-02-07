import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Binding var selectedTab: Int
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showingError = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Full Name field
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.white.opacity(0.6))
                TextField("Full Name", text: $fullName)
                    .autocapitalization(.words)
                    .foregroundColor(.white)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Email field
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.white.opacity(0.6))
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .foregroundColor(.white)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Password field
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.white.opacity(0.6))
                SecureField("Password", text: $password)
                    .textContentType(.newPassword)
                    .foregroundColor(.white)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Confirm Password field
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.white.opacity(0.6))
                SecureField("Confirm Password", text: $confirmPassword)
                    .textContentType(.newPassword)
                    .foregroundColor(.white)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Sign Up Button
            Button(action: {
                register()
            }) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                } else {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .alert("Error", isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
        .padding(.horizontal, 30)
    }
    
    private func register() {
        // Basic form validation
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty, password == confirmPassword else {
            errorMessage = "Please fill in all fields and make sure passwords match."
            showingError = true
            return
        }
        
        isLoading = true
        authManager.registerUser(email: email, password: password, fullName: fullName) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(_):
                    // Registration successful.
                    // Option: you could reset the tab or navigate elsewhere.
                    selectedTab = 0
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    showingError = true
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(selectedTab: .constant(1))
            .environmentObject(AuthenticationManager())
    }
} 