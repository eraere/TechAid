import Foundation
import SwiftData
@testable import TechAid

extension TechAidTests {
    func createTestCourse() -> Course {
        return MockData.sampleCourse
    }
    
    func createTestAchievement() -> Models.LearningAchievement {
        return MockData.sampleAchievement
    }
    
    func setupTestData() throws {
        let course = createTestCourse()
        modelContext.insert(course)
        try modelContext.save()
    }
    
    func clearTestData() throws {
        let descriptor = FetchDescriptor<Course>()
        let courses = try modelContext.fetch(descriptor)
        courses.forEach { modelContext.delete($0) }
        try modelContext.save()
    }
} 