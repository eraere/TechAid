import SwiftUI

struct CourseDetailView: View {
    let course: Course
    @Environment(\.dismiss) private var dismiss
    @State private var selectedLesson: Int = 0
    @State private var isAudioPlaying = false
    @State private var showingNotes = false
    @State private var showingExercises = false
    @State private var currentNote = ""
    @State private var showingSharingSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Course Header
                CourseHeaderView(course: course)
                
                // Course Progress
                CourseProgressView(course: course)
                
                // Course Content
                VStack(alignment: .leading, spacing: 16) {
                    Text("Course Content")
                        .font(.title2)
                        .bold()
                    
                    ForEach(course.lessons.indices, id: \.self) { index in
                        LessonRow(
                            lesson: course.lessons[index],
                            isCompleted: index < selectedLesson,
                            isCurrent: index == selectedLesson
                        )
                    }
                }
                
                // Audio Lessons Section
                if let currentLesson = selectedLesson < course.lessons.count ? course.lessons[selectedLesson] : nil {
                    AudioLessonSection(
                        lessonTitle: currentLesson,
                        isPlaying: $isAudioPlaying
                    )
                }
                
                // Interactive Elements
                HStack(spacing: 16) {
                    // Notes Button
                    ActionButton(
                        title: "Notes",
                        icon: "note.text",
                        color: .purple
                    ) {
                        showingNotes = true
                    }
                    
                    // Exercises Button
                    ActionButton(
                        title: "Exercises",
                        icon: "checkmark.circle",
                        color: .green
                    ) {
                        showingExercises = true
                    }
                    
                    // Share Progress Button
                    ActionButton(
                        title: "Share",
                        icon: "square.and.arrow.up",
                        color: .blue
                    ) {
                        showingSharingSheet = true
                    }
                }
                
                // Resources Section
                ResourcesSection()
                
                // Next Lesson Button
                if selectedLesson < course.lessons.count {
                    Button(action: { startNextLesson() }) {
                        HStack {
                            Text(selectedLesson == 0 ? "Start Course" : "Continue Learning")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "bookmark")
                        .foregroundColor(.blue)
                }
            }
        }
        .sheet(isPresented: $showingNotes) {
            NotesView(currentNote: $currentNote)
        }
        .sheet(isPresented: $showingExercises) {
            ExercisesView()
        }
        .sheet(isPresented: $showingSharingSheet) {
            ShareProgressView(course: course)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Course Details")
        .accessibilityHint("Swipe up or down to navigate through course content")
    }
    
    private func startNextLesson() {
        if selectedLesson < course.lessons.count {
            selectedLesson += 1
        }
    }
}

// MARK: - Supporting Views
private struct CourseHeaderView: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Course Title and Info
            VStack(alignment: .leading, spacing: 8) {
                Text(course.title)
                    .font(.title)
                    .bold()
                Text(course.courseDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // Course Stats
            HStack(spacing: 20) {
                StatItem(icon: "clock.fill", value: "\(course.totalHours) hours")
                StatItem(icon: "book.fill", value: "\(course.lessons.count) lessons")
                if let price = course.price {
                    StatItem(icon: "dollarsign.circle.fill", value: "$\(String(format: "%.2f", price))")
                }
            }
            
            // Course Level
            HStack {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                Text("Level: \(course.subtitle)")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}

private struct CourseProgressView: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Progress")
                .font(.headline)
            
            HStack {
                Text("\(Int(course.progress * 100))% Complete")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(course.completedHours)/\(course.totalHours) hours")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            ProgressView(value: course.progress)
                .tint(Color(course.color))
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}

private struct LessonRow: View {
    let lesson: String
    let isCompleted: Bool
    let isCurrent: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : isCurrent ? "circle.fill" : "circle")
                .foregroundColor(isCompleted ? .green : isCurrent ? .blue : .gray)
            
            Text(lesson)
                .font(.body)
            
            Spacer()
            
            if isCurrent {
                Text("Current")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

private struct ResourcesSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Additional Resources")
                .font(.title2)
                .bold()
            
            ForEach(["Course Notes", "Practice Exercises", "Helpful Links"], id: \.self) { resource in
                HStack {
                    Image(systemName: "doc.fill")
                        .foregroundColor(.blue)
                    Text(resource)
                    Spacer()
                    Image(systemName: "arrow.down.circle")
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}

private struct StatItem: View {
    let icon: String
    let value: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(value)
                .font(.subheadline)
        }
    }
}

// MARK: - New Supporting Views
private struct AudioLessonSection: View {
    let lessonTitle: String
    @Binding var isPlaying: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Audio Lesson")
                .font(.headline)
            
            HStack {
                Button(action: { isPlaying.toggle() }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                }
                .accessibilityLabel(isPlaying ? "Pause Audio" : "Play Audio")
                
                VStack(alignment: .leading) {
                    Text(lessonTitle)
                        .font(.subheadline)
                    ProgressView(value: 0.3)
                        .tint(.blue)
                }
            }
            
            // Audio Controls
            HStack {
                Button(action: {}) {
                    Image(systemName: "gobackward.10")
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "speaker.wave.2.fill")
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "goforward.10")
                }
            }
            .font(.title3)
            .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}

private struct NotesView: View {
    @Binding var currentNote: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $currentNote)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .font(.body)
            }
            .padding()
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

private struct ExercisesView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<3) { index in
                        ExerciseCard(index: index)
                    }
                }
                .padding()
            }
            .navigationTitle("Practice Exercises")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

private struct ExerciseCard: View {
    let index: Int
    @State private var selectedAnswer: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Question \(index + 1)")
                .font(.headline)
            
            Text("What is the main purpose of this feature?")
                .font(.body)
            
            ForEach(0..<4) { option in
                Button(action: { selectedAnswer = option }) {
                    HStack {
                        Image(systemName: selectedAnswer == option ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(selectedAnswer == option ? .green : .gray)
                        Text("Option \(option + 1)")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

private struct ShareProgressView: View {
    let course: Course
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Progress Summary
                VStack(alignment: .leading, spacing: 8) {
                    Text("Course Progress")
                        .font(.headline)
                    Text("\(Int(course.progress * 100))% Complete")
                    ProgressView(value: course.progress)
                        .tint(.blue)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                
                // Share Options
                ShareLink(
                    item: "I'm making progress in \(course.title)! Already completed \(Int(course.progress * 100))% of the course.",
                    subject: Text("My Learning Progress"),
                    message: Text("Check out my progress in this course!")
                )
                
                Spacer()
            }
            .padding()
            .navigationTitle("Share Progress")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

private struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 24))
                Text(title)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(0.1))
            .foregroundColor(color)
            .cornerRadius(10)
        }
    }
}

// Preview Helper
#Preview {
    NavigationView {
        CourseDetailView(
            course: Course(
                title: "AI Fundamentals",
                subtitle: "Introduction to AI",
                courseDescription: "Learn the basics of Artificial Intelligence",
                lessons: [
                    "Introduction to AI",
                    "Machine Learning Basics",
                    "Neural Networks",
                    "Deep Learning",
                    "Natural Language Processing"
                ],
                completedHours: 12,
                totalHours: 40,
                color: "#4A90E2"
            )
        )
    }
}

// Update the sample courses
let sampleCourses = [
    Course(
        title: "Getting Started",
        subtitle: "Beginner Friendly",
        courseDescription: "Learn the basics of using your device",
        lessons: ["Device Overview", "Basic Navigation", "Essential Apps"],
        completedHours: 2,
        totalHours: 5,
        color: "#4A90E2"
    ),
    Course(
        title: "Advanced Features",
        subtitle: "Intermediate Level",
        courseDescription: "Master advanced device features",
        lessons: ["Advanced Settings", "Security Features", "Cloud Services"],
        completedHours: 3,
        totalHours: 8,
        color: "#6B48FF"
    )
] 