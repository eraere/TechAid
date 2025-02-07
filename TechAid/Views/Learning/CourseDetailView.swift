// TechAid/Views/Learning/CourseDetailView.swift

import SwiftUI

// If you do not already have a Course model defined in your project,
// ensure that it is imported (e.g., via "import TechAid" or by including the file in your target).
// For testing purposes, you can uncomment the dummy definition below:
/*
struct Course: Identifiable {
    let id: String
    let title: String
    let lessons: [String]
    
    // For testing purposes:
    static let samples: [Course] = [
        Course(id: "1", title: "Swift Basics", lessons: ["Intro", "Variables", "Functions"]),
        Course(id: "2", title: "Advanced Swift", lessons: ["Closures", "Protocols", "Generics"])
    ]
}
*/

struct CourseDetailView: View {
    let course: Course
    
    // Explicit initializer to ensure unambiguous usage.
    init(course: Course) {
        self.course = course
    }
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedLesson: Int = 0
    @State private var isAudioPlaying: Bool = false
    @State private var showingNotes = false
    @State private var showingExercises = false
    @State private var currentNote = ""
    @State private var showingSharingSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
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
                if let currentLesson = (selectedLesson < course.lessons.count ? course.lessons[selectedLesson] : nil) {
                    AudioLessonSection(
                        lessonTitle: currentLesson,
                        isPlaying: $isAudioPlaying
                    )
                }
                
                // Interactive Elements
                HStack(spacing: 16) {
                    ActionButton(title: "Notes", icon: "note.text", color: .purple) {
                        showingNotes = true
                    }
                    ActionButton(title: "Exercises", icon: "checkmark.circle", color: .green) {
                        showingExercises = true
                    }
                    ActionButton(title: "Share", icon: "square.and.arrow.up", color: .blue) {
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

// MARK: - Dummy Implementations for Missing Components
// Remove these stubs if your project already defines these components.

struct CourseHeaderView: View {
    let course: Course
    var body: some View {
        Text("Header: \(course.title)")
            .font(.largeTitle)
    }
}

struct CourseProgressView: View {
    let course: Course
    var body: some View {
        Text("Progress: 50%")
    }
}

struct LessonRow: View {
    let lesson: String
    let isCompleted: Bool
    let isCurrent: Bool
    var body: some View {
        HStack {
            Text(lesson)
            if isCurrent {
                Text("(Current)")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct AudioLessonSection: View {
    let lessonTitle: String
    @Binding var isPlaying: Bool
    var body: some View {
        Text("Audio: \(lessonTitle)")
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .padding()
            .background(color.opacity(0.2))
            .cornerRadius(8)
        }
    }
}

struct ResourcesSection: View {
    var body: some View {
        Text("Resources Section")
    }
}

struct NotesView: View {
    @Binding var currentNote: String
    var body: some View {
        Text("Notes View")
    }
}

struct ExercisesView: View {
    var body: some View {
        Text("Exercises View")
    }
}

struct ShareProgressView: View {
    let course: Course
    var body: some View {
        Text("Share Progress: \(course.title)")
    }
}
