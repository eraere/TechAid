import SwiftUI

struct AnimatedBackgroundView: View {
    @State private var bubbles: [Bubble] = []
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Animated gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#4A90E2"),
                    Color(hex: "#6B48FF"),
                    Color(hex: "#8A2BE2")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .hueRotation(.degrees(isAnimating ? 45 : 0))
            .animation(
                Animation.easeInOut(duration: 5)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            
            // Glowing overlay
            RadialGradient(
                gradient: Gradient(colors: [
                    .white.opacity(0.2),
                    .clear
                ]),
                center: .center,
                startRadius: 0,
                endRadius: 300
            )
            .scaleEffect(isAnimating ? 1.2 : 0.8)
            .animation(
                Animation.easeInOut(duration: 4)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            
            // Animated bubbles
            ForEach(bubbles) { bubble in
                BubbleView(bubble: bubble)
            }
            
            // Overlay gradient for better text visibility
            LinearGradient(
                gradient: Gradient(colors: [
                    .black.opacity(0.3),
                    .clear,
                    .black.opacity(0.3)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .ignoresSafeArea()
        .onAppear {
            isAnimating = true
            createBubbles()
        }
    }
    
    private func createBubbles() {
        for _ in 0..<15 {
            let bubble = Bubble()
            bubbles.append(bubble)
        }
    }
}

struct BubbleView: View {
    let bubble: Bubble
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .fill(bubble.color.opacity(0.3))
            .frame(width: bubble.size, height: bubble.size)
            .background(
                Circle()
                    .fill(bubble.color.opacity(0.1))
                    .frame(width: bubble.size * 1.2, height: bubble.size * 1.2)
                    .blur(radius: 20)
            )
            .overlay(
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.3),
                                .clear
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: bubble.size / 2
                        )
                    )
                    .scaleEffect(0.8)
            )
            .position(bubble.position)
            .blur(radius: 15)
            .scaleEffect(isAnimating ? 1.1 : 0.9)
            .onAppear {
                withAnimation(
                    Animation
                        .linear(duration: Double.random(in: 15...25))
                        .repeatForever(autoreverses: false)
                ) {
                    bubble.position.y = -200
                }
                
                withAnimation(
                    Animation
                        .easeInOut(duration: Double.random(in: 2...4))
                        .repeatForever(autoreverses: true)
                ) {
                    isAnimating = true
                }
            }
    }
}

// Premium Button Styles
struct PremiumButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    var isSecondary: Bool = false
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                action()
            }
        }) {
            HStack(spacing: 12) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                }
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(
                ZStack {
                    if isSecondary {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.white.opacity(0.3), lineWidth: 1)
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(hex: "#4A90E2"),
                                        Color(hex: "#6B48FF")
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                    
                    // Shine effect
                    RoundedRectangle(cornerRadius: 15)
                        .fill(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.2),
                                    .clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .opacity(isPressed ? 0 : 1)
                }
            )
            .foregroundColor(.white)
            .scaleEffect(isPressed ? 0.98 : 1)
            .shadow(color: isSecondary ? .clear : .black.opacity(0.2),
                   radius: isPressed ? 4 : 8,
                   x: 0,
                   y: isPressed ? 2 : 4)
        }
    }
}

class Bubble: Identifiable, ObservableObject {
    let id = UUID()
    var size: CGFloat
    var color: Color
    @Published var position: CGPoint
    
    init() {
        size = CGFloat.random(in: 100...300)
        color = [
            Color(hex: "#4A90E2"),  // Blue
            Color(hex: "#6B48FF"),  // Purple
            Color(hex: "#4CD964"),  // Green
            Color(hex: "#FF3B30"),  // Red
            Color(hex: "#FF9500")   // Orange
        ].randomElement() ?? .blue
        
        position = CGPoint(
            x: CGFloat.random(in: -100...500),
            y: CGFloat.random(in: 700...1000)
        )
    }
}

#Preview {
    AnimatedBackgroundView()
} 