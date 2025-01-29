import Foundation
@testable import TechAid

enum MockData {
    static let sampleCourse = Course(
        title: "Sample Course",
        subtitle: "Test Course",
        courseDescription: "This is a test course",
        lessons: ["Lesson 1", "Lesson 2"],
        completedHours: 1,
        totalHours: 2,
        color: "#4A90E2"
    )
    
    static let sampleAchievement = Models.LearningAchievement(
        title: "Test Achievement",
        icon: "star.fill",
        color: .blue,
        description: "Test achievement description"
    )
} 