import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.modelContext) private var modelContext
    @State private var selectedCourse: Course?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Welcome Section
                PremiumCard {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Welcome back")
                                    .font(.title2)
                                    .foregroundColor(.white.opacity(0.9))
                                Text(authManager.currentUser?.name ?? "User")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            
                            Image(systemName: "brain.head.profile")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                        
                        // Progress Overview
                        HStack {
                            ProgressStat(value: "80%", title: "Complete")
                            ProgressStat(value: "4.8", title: "Hours Today")
                            ProgressStat(value: "12", title: "Day Streak")
                        }
                    }
                }
                
                // Daily Goals
                VStack(alignment: .leading, spacing: 15) {
                    SectionTitle(title: "Daily Goals")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<3) { _ in
                                DailyGoalCard()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Continue Learning
                VStack(alignment: .leading, spacing: 15) {
                    SectionTitle(title: "Continue Learning")
                    
                    ForEach(Course.samples) { course in
                        CourseProgressCard(course: course) {
                            selectedCourse = course
                        }
                    }
                }
                
                // Recommended Courses
                VStack(alignment: .leading, spacing: 15) {
                    SectionTitle(title: "Recommended for You")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(Course.samples) { course in
                                RecommendedCourseCard(course: course)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Featured Course - Getting Started
                PremiumCard(
                    gradient: [Color(hex: "#FF6B6B"), Color(hex: "#FF8E53")]
                ) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Visual Header
                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.1))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, -10)
                        
                        // Course Badge
                        Text("FEATURED")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(.white.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("Getting Started with Digital Life")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Learn essential skills for using your smartphone and tablet with confidence")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.9))
                        
                        // Visual Stats
                        HStack(spacing: 20) {
                            HStack(spacing: 8) {
                                ZStack {
                                    Circle()
                                        .fill(.white.opacity(0.2))
                                        .frame(width: 36, height: 36)
                                    Image(systemName: "book.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                Text("5 Easy Lessons")
                                    .font(.title3)
                            }
                            Spacer()
                            HStack(spacing: 8) {
                                ZStack {
                                    Circle()
                                        .fill(.white.opacity(0.2))
                                        .frame(width: 36, height: 36)
                                    Image(systemName: "clock.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                Text("30 Minutes")
                                    .font(.title3)
                            }
                        }
                        .foregroundColor(.white.opacity(0.9))
                        
                        // Start Button with Visual
                        Button(action: {}) {
                            HStack {
                                Text("Start Here")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Spacer()
                                ZStack {
                                    Circle()
                                        .fill(.white.opacity(0.2))
                                        .frame(width: 36, height: 36)
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color(hex: "#FF6B6B"))
                                }
                            }
                            .padding()
                            .background(.white)
                            .foregroundColor(Color(hex: "#FF6B6B"))
                            .cornerRadius(15)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .background(Color(hex: "#F5F7FA"))
        .navigationTitle("Home")
        .sheet(item: $selectedCourse) { course in
            CourseDetailView(course: course)
        }
    }
}

// MARK: - Supporting Views
struct ProgressStat: View {
    let value: String
    let title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(.white.opacity(0.1))
        .cornerRadius(12)
    }
}

struct DailyGoalCard: View {
    var goals = [
        "Make your first video call",
        "Send an email to family",
        "Check the weather app",
        "Set a calendar reminder",
        "Browse a news website"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "star.fill")
                .font(.title2)
                .foregroundColor(.yellow)
            
            Text(goals.randomElement() ?? "Complete Today's Lesson")
                .font(.headline)
            
            Text("15 minutes left")
                .font(.caption)
                .foregroundColor(.gray)
            
            ProgressView(value: 0.7)
                .tint(.blue)
        }
        .padding()
        .frame(width: 200)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct RecommendedCourseCard: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Course Header with Visual
            ZStack(alignment: .topLeading) {
                // Background Gradient
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(hex: course.color),
                                Color(hex: course.color).opacity(0.8)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 160)
                    .overlay(
                        // Pattern Overlay
                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.1))
                                .frame(width: 100)
                                .offset(x: -20, y: -20)
                            Circle()
                                .fill(.white.opacity(0.1))
                                .frame(width: 80)
                                .offset(x: 140, y: 60)
                        }
                    )
                
                VStack(alignment: .leading, spacing: 12) {
                    // Course Icon
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.2))
                            .frame(width: 50, height: 50)
                        Image(systemName: "graduationcap.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                    
                    // Course Level Badge
                    Text(course.subtitle)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                .padding()
            }
            
            // Course Info
            VStack(alignment: .leading, spacing: 12) {
                Text(course.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(course.courseDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                // Course Stats
                HStack(spacing: 16) {
                    // Modules
                    HStack(spacing: 6) {
                        Image(systemName: "book.fill")
                            .foregroundColor(Color(hex: course.color))
                        Text("\(course.lessons.count) Modules")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Duration
                    HStack(spacing: 6) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(Color(hex: course.color))
                        Text("\(course.totalHours) hours")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // Price if available
                    if let price = course.price {
                        Text("$\(String(format: "%.2f", price))")
                            .font(.headline)
                            .foregroundColor(Color(hex: course.color))
                    }
                }
            }
            .padding(.horizontal)
            
            // Start Learning Button
            Button(action: {}) {
                HStack {
                    Text("Learn More")
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .padding()
                .background(Color(hex: course.color).opacity(0.1))
                .foregroundColor(Color(hex: course.color))
                .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .frame(width: 300)
    }
}

struct SectionTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        HomeView()
            .environmentObject(AuthenticationManager())
    }
} 
