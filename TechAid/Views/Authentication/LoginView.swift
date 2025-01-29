import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var email = ""
    @State private var password = ""
    @State private var showingError = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Animated background
            AnimatedBackgroundView()
            
            // Content
            VStack(spacing: 30) {
                Spacer()
                    .frame(height: 50)
                
                // Logo and Title
                VStack(spacing: 16) {
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                    
                    Text("TechAid+")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Your AI Learning Companion")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                // Sign In/Sign Up Tabs
                HStack(spacing: 0) {
                    TabButton(title: "Sign In", isSelected: selectedTab == 0) {
                        withAnimation { selectedTab = 0 }
                    }
                    TabButton(title: "Sign Up", isSelected: selectedTab == 1) {
                        withAnimation { selectedTab = 1 }
                    }
                }
                .background(.ultraThinMaterial)
                .cornerRadius(30)
                .padding(.horizontal, 30)
                .padding(.top, 30)
                
                // Login Form
                if selectedTab == 0 {
                    VStack(spacing: 20) {
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
                                .textContentType(.password)
                                .foregroundColor(.white)
                            Button(action: {}) {
                                Image(systemName: "eye")
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                        
                        // Login Button
                        Button(action: {
                            Task {
                                await handleLogin()
                            }
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .alert("Error", isPresented: $showingError) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text(errorMessage)
                        }
                        
                        // Face ID Button
                        Button(action: signInWithFaceID) {
                            HStack {
                                Image(systemName: "faceid")
                                Text("Continue with Face ID")
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(.ultraThinMaterial)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 30)
                } else {
                    SignUpView(selectedTab: $selectedTab)
                }
                
                Spacer()
                
                // Social Sign In
                VStack(spacing: 16) {
                    Text("Or continue with")
                        .foregroundColor(.white.opacity(0.6))
                    
                    HStack(spacing: 20) {
                        SocialButton(image: "apple.logo", action: {})
                        SocialButton(image: "g.circle.fill", action: {})
                        SocialButton(image: "envelope.fill", action: {})
                    }
                }
                .padding(.bottom, 30)
            }
        }
    }
    
    private func handleLogin() async {
        do {
            _ = try await authManager.signIn(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
            showingError = true
        }
    }
    
    private func signInWithFaceID() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            authManager.signInWithFaceID()
            isLoading = false
        }
    }
}

// MARK: - Supporting Views
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .white : .white.opacity(0.6))
                .frame(width: 120, height: 40)
                .background(isSelected ? .white.opacity(0.2) : .clear)
                .cornerRadius(20)
        }
    }
}

struct SocialButton: View {
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .font(.title2)
                .frame(width: 60, height: 60)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .foregroundColor(.white)
        }
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationManager())
} 