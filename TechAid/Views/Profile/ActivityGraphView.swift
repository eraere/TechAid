import SwiftUI

struct ActivityGraphView: View {
    let data: [Double] = [0.3, 0.5, 0.8, 0.4, 0.9, 0.7, 0.6]
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(data.indices, id: \.self) { index in
                    VStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "#4A90E2"), Color(hex: "#6B48FF")],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 160 * data[index])
                        
                        Text("D\(index + 1)")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
} 