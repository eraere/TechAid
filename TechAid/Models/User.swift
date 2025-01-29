import Foundation
import SwiftData

@Model
final class User {
    var id: String
    var name: String
    var title: String
    var courses: [Course]
    var totalHours: Int
    var certificates: Int
    
    init(id: String = UUID().uuidString, 
         name: String, 
         title: String = "AI Enthusiast",
         courses: [Course] = [],
         totalHours: Int = 0,
         certificates: Int = 0) {
        self.id = id
        self.name = name
        self.title = title
        self.courses = courses
        self.totalHours = totalHours
        self.certificates = certificates
    }
} 