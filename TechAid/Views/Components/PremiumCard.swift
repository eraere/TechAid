import SwiftUI

struct PremiumCard<Content: View>: View {
    let gradient: [Color]
    @ViewBuilder let content: () -> Content
    
    init(
        gradient: [Color] = [
            Color(hex: "#4A90E2"),
            Color(hex: "#6B48FF")
        ],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.gradient = gradient
        self.content = content
    }
    
    var body: some View {
        content()
            .padding()
            .background(
                ZStack {
                    LinearGradient(
                        colors: gradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    // Shine effect
                    LinearGradient(
                        colors: [
                            .white.opacity(0.2),
                            .clear
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            )
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
} 