//
//  TechAidTests.swift
//  TechAidTests
//
//  Created by Era Aliu on 29.1.25.
//

import XCTest
import SwiftData
import SwiftUI  // Add this for Color
@testable import TechAid

final class TechAidTests: XCTestCase {
    // Test properties
    var authManager: AuthenticationManager!
    var modelContext: ModelContext!
    
    override func setUp() {
        super.setUp()
        authManager = AuthenticationManager()
        
        // Setup in-memory SwiftData store for testing
        let schema = Schema([Course.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            modelContext = ModelContext(container)
        } catch {
            XCTFail("Failed to create ModelContainer: \(error)")
        }
    }
    
    override func tearDown() {
        authManager = nil
        modelContext = nil
        super.tearDown()
    }
    
    // MARK: - Course Tests
    func testCourseCreation() {
        let course = Course(
            title: "Test Course",
            subtitle: "Test Subtitle",
            courseDescription: "Test Description",
            lessons: ["Lesson 1", "Lesson 2"],
            completedHours: 1,
            totalHours: 2,
            color: "#4A90E2"
        )
        
        XCTAssertEqual(course.title, "Test Course")
        XCTAssertEqual(course.lessons.count, 2)
        XCTAssertEqual(course.progress, 0.5)
    }
    
    // MARK: - Achievement Tests
    func testAchievementCreation() {
        let achievement = Models.LearningAchievement(
            title: "Test Achievement",
            icon: "star.fill",
            color: Color.blue,
            description: "Test Description"
        )
        
        XCTAssertEqual(achievement.title, "Test Achievement")
        XCTAssertNotNil(achievement.id)
    }
    
    // MARK: - Authentication Tests
    func testUserSignIn() async throws {
        let user = try await authManager.signIn(email: "test@example.com", password: "password")
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user.name, "John Doe")
        XCTAssertTrue(authManager.isAuthenticated)
        XCTAssertNotNil(authManager.currentUser)
    }
    
    func testSignOut() {
        // Setup
        authManager.isAuthenticated = true
        authManager.currentUser = User(name: "Test User")
        
        // Test
        authManager.signOut()
        
        // Verify
        XCTAssertFalse(authManager.isAuthenticated)
        XCTAssertNil(authManager.currentUser)
    }
    
    func testAuthenticationError() async {
        let mockService = MockAuthenticationService()
        mockService.shouldSucceed = false
        
        do {
            _ = try await mockService.signIn(email: "test@example.com", password: "wrong")
            XCTFail("Should not succeed with invalid credentials")
        } catch {
            // Expected failure
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - Course Progress Tests
    func testCourseProgress() {
        let course = Course(
            title: "Progress Test",
            subtitle: "Test",
            courseDescription: "Test",
            lessons: ["L1", "L2", "L3"],
            completedHours: 2,
            totalHours: 4,
            color: "#000000"
        )
        
        XCTAssertEqual(course.progress, 0.5)
        
        // Test progress update
        course.completedHours = 4
        XCTAssertEqual(course.progress, 1.0)
    }
    
    // MARK: - Data Persistence Tests
    func testCoursePersistence() throws {
        // Create and save a course
        let course = Course(
            title: "Persistence Test",
            subtitle: "Test",
            courseDescription: "Test",
            lessons: ["L1"],
            completedHours: 0,
            totalHours: 1,
            color: "#000000"
        )
        
        modelContext.insert(course)
        try modelContext.save()
        
        // Fetch and verify
        let descriptor = FetchDescriptor<Course>(
            predicate: #Predicate<Course> { course in
                course.title == "Persistence Test"
            }
        )
        
        let fetchedCourses = try modelContext.fetch(descriptor)
        XCTAssertEqual(fetchedCourses.count, 1)
        XCTAssertEqual(fetchedCourses.first?.title, "Persistence Test")
    }
    
    // MARK: - View Model Tests
    func testCourseViewModel() {
        // Test course data
        let course = createTestCourse()
        modelContext.insert(course)
        
        // Test fetching
        let fetchDescriptor = FetchDescriptor<Course>()
        let courses = try? modelContext.fetch(fetchDescriptor)
        
        XCTAssertNotNil(courses)
        XCTAssertFalse(courses?.isEmpty ?? true)
    }
    
    // MARK: - Color Tests
    func testColorHexConversion() {
        let color = Color(hex: "#4A90E2")
        XCTAssertNotNil(color)
    }
    
    // MARK: - Navigation Tests
    func testTabNavigation() {
        // Assuming you have a Tab enum in your app
        @State var selectedTab: Tab = .home
        
        // Test tab selection
        selectedTab = .learn
        XCTAssertEqual(selectedTab, .learn)
    }
    
    // MARK: - Data Validation Tests
    func testCourseValidation() {
        let invalidCourse = Course(
            title: "",
            subtitle: "",
            courseDescription: "",
            lessons: [],
            completedHours: -1,
            totalHours: 0,
            color: "invalid"
        )
        
        XCTAssertEqual(invalidCourse.progress, 0)
        XCTAssertTrue(invalidCourse.lessons.isEmpty)
    }
}

// Add this enum if you don't have it already
enum Tab {
    case home
    case learn
    case profile
}
