import SwiftUI

struct EnhancedAchievementView: View {
    let achievement: Models.LearningAchievement
    @State private var showDetails = false
    
    var body: some View {
        Button(action: { showDetails.toggle() }) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(achievement.color.opacity(0.1))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: achievement.icon)
                        .font(.system(size: 30))
                        .foregroundColor(achievement.color)
                }
                
                Text(achievement.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.05), radius: 5)
        }
        .sheet(isPresented: $showDetails) {
            AchievementDetailView(achievement: achievement)
        }
    }
} 