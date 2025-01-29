import SwiftUI

enum Models {
    struct LearningAchievement: Identifiable {
        let id = UUID()
        let title: String
        let icon: String
        let color: Color
        let description: String
        
        static let samples = [
            LearningAchievement(
                title: "First Steps",
                icon: "1.circle.fill",
                color: Color.blue,
                description: "Completed your first digital basics lesson"
            ),
            LearningAchievement(
                title: "Connected",
                icon: "wifi",
                color: Color.green,
                description: "Successfully set up your first email"
            ),
            LearningAchievement(
                title: "Social Star",
                icon: "video.fill",
                color: Color.purple,
                description: "Made your first video call"
            ),
            LearningAchievement(
                title: "Safety First",
                icon: "lock.fill",
                color: Color.orange,
                description: "Completed the internet safety course"
            ),
            LearningAchievement(
                title: "Digital Explorer",
                icon: "safari.fill",
                color: Color.blue,
                description: "Browsed the internet independently"
            ),
            LearningAchievement(
                title: "App Master",
                icon: "square.grid.2x2.fill",
                color: Color.green,
                description: "Used 5 different apps successfully"
            )
        ]
    }
} 