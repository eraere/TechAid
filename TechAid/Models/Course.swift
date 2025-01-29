import Foundation
import SwiftData

@Model
final class Course {
    var id: String
    var title: String
    var subtitle: String  // Changed from description
    var courseDescription: String
    var lessons: [String]
    var completedHours: Int
    var totalHours: Int
    var color: String
    var price: Double?
    
    var progress: Double {
        return Double(completedHours) / Double(totalHours)
    }
    
    init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String = "",
        courseDescription: String,
        lessons: [String],
        completedHours: Int,
        totalHours: Int,
        color: String,
        price: Double? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.courseDescription = courseDescription
        self.lessons = lessons
        self.completedHours = completedHours
        self.totalHours = totalHours
        self.color = color
        self.price = price
    }
}

// MARK: - Identifiable
extension Course: Identifiable {}

// MARK: - Sample Data
extension Course {
    static let samples = [
        Course(
            title: "Digital Basics",
            subtitle: "Beginner Friendly",
            courseDescription: "Learn the essential skills for using your digital devices",
            lessons: [
                "Understanding Your Device",
                "Using the Touchscreen",
                "Basic Device Settings",
                "Internet Safety Basics",
                "Staying Connected"
            ],
            completedHours: 2,
            totalHours: 5,
            color: "#4A90E2"
        ),
        Course(
            title: "Internet & Email",
            subtitle: "Getting Started",
            courseDescription: "Master the basics of internet browsing and email",
            lessons: [
                "Web Browser Basics",
                "Using Search Engines",
                "Setting Up Email",
                "Sending & Receiving Emails",
                "Internet Safety"
            ],
            completedHours: 1,
            totalHours: 4,
            color: "#6B48FF"
        ),
        Course(
            title: "Social Connection",
            subtitle: "Stay Connected",
            courseDescription: "Learn to connect with family and friends digitally",
            lessons: [
                "Video Calls Made Easy",
                "Messaging Apps",
                "Sharing Photos",
                "Social Media Basics",
                "Online Safety"
            ],
            completedHours: 1,
            totalHours: 3,
            color: "#2ECC71"
        ),
        Course(
            title: "Everyday Apps",
            subtitle: "Daily Digital Tasks",
            courseDescription: "Essential apps for daily life",
            lessons: [
                "Calendar & Reminders",
                "Notes & Lists",
                "Weather Apps",
                "Maps & Navigation",
                "Health & Wellness Apps"
            ],
            completedHours: 0,
            totalHours: 4,
            color: "#FF9500"
        ),
        Course(
            title: "Digital Entertainment",
            subtitle: "Fun & Learning",
            courseDescription: "Discover entertainment on your device",
            lessons: [
                "Streaming Services",
                "eBooks & Reading",
                "Podcasts & Music",
                "Games & Puzzles",
                "Learning Apps"
            ],
            completedHours: 0,
            totalHours: 3,
            color: "#FF6B6B"
        ),
        Course(
            title: "Online Shopping",
            subtitle: "Shop Safely",
            courseDescription: "Learn to shop online safely and securely",
            lessons: [
                "Shopping Basics",
                "Finding Best Deals",
                "Secure Payments",
                "Delivery Tracking",
                "Returns & Support"
            ],
            completedHours: 0,
            totalHours: 3,
            color: "#9B51E0"
        )
    ]
} 
