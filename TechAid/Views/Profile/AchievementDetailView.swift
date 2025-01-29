import SwiftUI

struct AchievementDetailView: View {
    let achievement: Models.LearningAchievement
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Achievement Icon
                    ZStack {
                        Circle()
                            .fill(achievement.color.opacity(0.1))
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: achievement.icon)
                            .font(.system(size: 60))
                            .foregroundColor(achievement.color)
                    }
                    
                    // Achievement Info
                    VStack(spacing: 12) {
                        Text(achievement.title)
                            .font(.title2)
                            .bold()
                        
                        Text("Earned on March 15, 2024")
                            .foregroundColor(.gray)
                    }
                    
                    // Description
                    Text(achievement.description)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                    
                    // Share Button
                    ShareLink(
                        item: "I just earned the \(achievement.title) achievement on TechAid+!",
                        subject: Text("My Achievement"),
                        message: Text("Check out my latest achievement!")
                    )
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .navigationTitle("Achievement Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
} 