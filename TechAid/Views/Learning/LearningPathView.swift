import SwiftUI

struct LearningPathView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    @State private var showFilters = false
    
    let categories = ["All", "Getting Started", "Daily Tasks", "Communication", "Entertainment", "Safety"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Search and Filter with larger text
                HStack(spacing: 15) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.title2)
                        TextField("Search your courses...", text: $searchText)
                            .font(.title3)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Filter Button
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(14)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "#4A90E2"), Color(hex: "#6B48FF")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                    }
                }
                
                // Categories with larger text
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryPill(
                                title: category,
                                isSelected: category == selectedCategory,
                                action: { selectedCategory = category }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Featured Course - Getting Started
                PremiumCard(
                    gradient: [Color(hex: "#FF6B6B"), Color(hex: "#FF8E53")]
                ) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Course Badge
                        Text("RECOMMENDED FOR YOU")
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(.white.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("Getting Started with Your Device")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Learn the basics of using your device with easy-to-follow guides")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.9))
                        
                        HStack(spacing: 20) {
                            HStack(spacing: 8) {
                                Image(systemName: "book.fill")
                                    .font(.title3)
                                Text("5 Easy Lessons")
                                    .font(.title3)
                            }
                            Spacer()
                            HStack(spacing: 8) {
                                Image(systemName: "clock.fill")
                                    .font(.title3)
                                Text("30 Minutes")
                                    .font(.title3)
                            }
                        }
                        .foregroundColor(.white.opacity(0.9))
                        
                        Button(action: {}) {
                            Text("Start Here")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "#FF6B6B"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(.white)
                                .cornerRadius(15)
                        }
                    }
                }
                
                // Learning Paths
                VStack(alignment: .leading, spacing: 25) {
                    Text("Your Learning Journey")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // Beginner Path
                    LearningPathCard(
                        course: Course(
                            title: "Device Basics",
                            subtitle: "For Beginners",
                            courseDescription: "Master the fundamental skills of using your device",
                            lessons: [
                                "Understanding Your Home Screen",
                                "Making Your First Call",
                                "Sending Messages to Family"
                            ],
                            completedHours: 1,
                            totalHours: 2,
                            color: "#4A90E2"
                        )
                    )
                    
                    // Intermediate Path
                    LearningPathCard(
                        course: Course(
                            title: "Staying Connected",
                            subtitle: "Intermediate",
                            courseDescription: "Learn to use video calls and social apps",
                            lessons: [
                                "Setting Up Video Calls",
                                "Sharing Photos with Family",
                                "Using Social Media Safely"
                            ],
                            completedHours: 2,
                            totalHours: 4,
                            color: "#6B48FF"
                        )
                    )
                    
                    // Advanced Path
                    LearningPathCard(
                        course: Course(
                            title: "Digital Safety",
                            subtitle: "Advanced",
                            courseDescription: "Stay safe online and protect your information",
                            lessons: [
                                "Understanding Online Privacy",
                                "Avoiding Common Scams",
                                "Securing Your Accounts"
                            ],
                            completedHours: 1,
                            totalHours: 3,
                            color: "#2ECC71"
                        )
                    )
                }
            }
            .padding()
        }
        .background(Color(hex: "#F5F7FA"))
        .navigationTitle("Learn")
    }
}

// MARK: - Supporting Views
struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Group {
                        if isSelected {
                            LinearGradient(
                                colors: [Color(hex: "#4A90E2"), Color(hex: "#6B48FF")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        } else {
                            Color.white
                        }
                    }
                )
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

struct LearningPathCard: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(course.title)
                        .font(.headline)
                    Text(course.courseDescription)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                CircularProgress(progress: course.progress)
            }
            
            // Lessons
            VStack(spacing: 12) {
                ForEach(course.lessons.prefix(3), id: \.self) { lesson in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text(lesson)
                            .font(.subheadline)
                        Spacer()
                    }
                }
            }
            
            Button(action: {}) {
                Text("Continue Learning")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "#4A90E2"), Color(hex: "#6B48FF")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct CircularProgress: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 8)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        colors: [Color(hex: "#4A90E2"), Color(hex: "#6B48FF")],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress * 100))%")
                .font(.caption)
                .fontWeight(.bold)
        }
        .frame(width: 50, height: 50)
    }
}

#Preview {
    NavigationView {
        LearningPathView()
    }
} 