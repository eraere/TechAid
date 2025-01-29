import XCTest
@testable import TechAid

final class TechAidPerformanceTests: XCTestCase {
    func testCourseLoadingPerformance() throws {
        measure {
            let _ = Course.samples
        }
    }
    
    func testAchievementLoadingPerformance() throws {
        measure {
            let _ = Models.LearningAchievement.samples
        }
    }
} 