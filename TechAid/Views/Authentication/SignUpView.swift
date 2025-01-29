import SwiftUI

struct SignUpView: View {
    @Binding var selectedTab: Int
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Full Name field
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.white.opacity(0.6))
                TextField("Full Name", text: $fullName)
                    .textContentType(.name)
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
                Group {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                }
                .textContentType(.newPassword)
                .foregroundColor(.white)
                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Confirm Password field
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.white.opacity(0.6))
                Group {
                    if showConfirmPassword {
                        TextField("Confirm Password", text: $confirmPassword)
                    } else {
                        SecureField("Confirm Password", text: $confirmPassword)
                    }
                }
                .textContentType(.newPassword)
                .foregroundColor(.white)
                Button(action: { showConfirmPassword.toggle() }) {
                    Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Sign Up Button
            Button(action: signUp) {
                ZStack {
                    LinearGradient(
                        colors: [Color(hex: "#4A90E2"), Color(hex: "#6B48FF")],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .cornerRadius(15)
                    
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(height: 55)
            }
            
            // Terms and Conditions
            VStack(spacing: 8) {
                Text("By signing up, you agree to our")
                    .foregroundColor(.white.opacity(0.6))
                HStack(spacing: 4) {
                    Button(action: { /* Show Terms */ }) {
                        Text("Terms of Service")
                            .underline()
                    }
                    Text("and")
                        .foregroundColor(.white.opacity(0.6))
                    Button(action: { /* Show Privacy */ }) {
                        Text("Privacy Policy")
                            .underline()
                    }
                }
                .font(.footnote)
                .foregroundColor(.white)
            }
            
            // Already have an account
            HStack(spacing: 4) {
                Text("Already have an account?")
                    .foregroundColor(.white.opacity(0.6))
                Button(action: { withAnimation { selectedTab = 0 } }) {
                    Text("Sign In")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .font(.subheadline)
        }
        .padding(.horizontal, 30)
    }
    
    private func signUp() {
        // Implement sign up logic
    }
} 