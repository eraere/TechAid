import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 8)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        colors: [Color(hex: "#4A90E2"), Color(hex: "#6B48FF")],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress * 100))%")
                .font(.caption)
                .fontWeight(.bold)
        }
        .frame(width: 50, height: 50)
    }
} 