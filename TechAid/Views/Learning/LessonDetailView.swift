import SwiftUI
import AVKit

struct LessonDetailView: View {
    let lesson: String
    @State private var currentStep = 0
    @State private var showingPractice = false
    @State private var hasCompletedPractice = false
    @Environment(\.dismiss) private var dismiss
    
    let steps = [
        LessonStep(
            title: "Introduction",
            content: "Let's learn how to use your device safely and effectively.",
            type: .text
        ),
        LessonStep(
            title: "Watch Demo",
            content: "exampleVideo",
            type: .video
        ),
        LessonStep(
            title: "Try It Yourself",
            content: "Now it's your turn to practice",
            type: .interactive
        ),
        LessonStep(
            title: "Summary",
            content: "Great job! You've learned the basics.",
            type: .text
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Progress Indicator
                ProgressView(value: Double(currentStep) / Double(steps.count))
                    .tint(.blue)
                    .padding(.horizontal)
                
                // Current Step Content
                if currentStep < steps.count {
                    let step = steps[currentStep]
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Step \(currentStep + 1) of \(steps.count)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(step.title)
                            .font(.title2)
                            .bold()
                        
                        switch step.type {
                        case .text:
                            TextStepView(content: step.content)
                        case .video:
                            VideoStepView(videoName: step.content)
                        case .interactive:
                            InteractiveStepView(showingPractice: $showingPractice)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                }
                
                // Navigation Buttons
                HStack(spacing: 20) {
                    if currentStep > 0 {
                        Button(action: { currentStep -= 1 }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Previous")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                        }
                    }
                    
                    if currentStep < steps.count - 1 {
                        Button(action: { currentStep += 1 }) {
                            HStack {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    } else if !hasCompletedPractice {
                        Button(action: { showingPractice = true }) {
                            Text("Complete Practice")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                // Help Button
                Button(action: { /* Show help */ }) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                        Text("Need Help?")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle(lesson)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingPractice) {
            PracticeView(hasCompleted: $hasCompletedPractice)
        }
    }
}

// MARK: - Supporting Views
private struct TextStepView: View {
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(content)
                .font(.body)
                .lineSpacing(4)
            
            // Text-to-Speech Button
            Button(action: { /* Implement text-to-speech */ }) {
                HStack {
                    Image(systemName: "speaker.wave.2")
                    Text("Listen")
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .cornerRadius(8)
            }
        }
    }
}

private struct VideoStepView: View {
    let videoName: String
    @State private var isPlaying = false
    
    var body: some View {
        VStack(spacing: 12) {
            // Video Player would go here
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .aspectRatio(16/9, contentMode: .fit)
                .overlay(
                    Button(action: { isPlaying.toggle() }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                )
            
            // Video Controls
            HStack {
                Button(action: {}) {
                    Image(systemName: "gobackward.10")
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "speaker.wave.2")
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "goforward.10")
                }
            }
            .font(.title3)
            .foregroundColor(.blue)
            .padding(.horizontal)
        }
    }
}

private struct InteractiveStepView: View {
    @Binding var showingPractice: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Time to practice what you've learned!")
                .font(.headline)
            
            Text("Complete these simple exercises to make sure you understand everything.")
                .font(.body)
                .foregroundColor(.gray)
            
            Button(action: { showingPractice = true }) {
                Text("Start Practice")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

private struct PracticeView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var hasCompleted: Bool
    @State private var currentQuestion = 0
    
    let questions = [
        PracticeQuestion(
            question: "What should you do first when using your device?",
            options: [
                "Turn it on",
                "Check the battery",
                "Call someone",
                "Download apps"
            ],
            correctAnswer: 1
        ),
        // Add more questions...
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if currentQuestion < questions.count {
                    QuestionView(
                        question: questions[currentQuestion],
                        onCorrect: {
                            if currentQuestion < questions.count - 1 {
                                currentQuestion += 1
                            } else {
                                hasCompleted = true
                                dismiss()
                            }
                        }
                    )
                }
            }
            .padding()
            .navigationTitle("Practice")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Models
struct LessonStep {
    let title: String
    let content: String
    let type: StepType
    
    enum StepType {
        case text
        case video
        case interactive
    }
}

struct PracticeQuestion {
    let question: String
    let options: [String]
    let correctAnswer: Int
}

private struct QuestionView: View {
    let question: PracticeQuestion
    let onCorrect: () -> Void
    @State private var selectedAnswer: Int?
    @State private var hasSubmitted = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.question)
                .font(.title3)
                .bold()
            
            VStack(spacing: 12) {
                ForEach(question.options.indices, id: \.self) { index in
                    Button(action: { selectedAnswer = index }) {
                        HStack {
                            Image(systemName: selectedAnswer == index ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(
                                    hasSubmitted
                                    ? (index == question.correctAnswer ? .green : .red)
                                    : .blue
                                )
                            Text(question.options[index])
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.1))
                        )
                    }
                    .disabled(hasSubmitted)
                }
            }
            
            if !hasSubmitted {
                Button(action: {
                    hasSubmitted = true
                    if selectedAnswer == question.correctAnswer {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            onCorrect()
                        }
                    }
                }) {
                    Text("Submit Answer")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedAnswer == nil)
            }
            
            if hasSubmitted {
                Text(selectedAnswer == question.correctAnswer ? "Correct! Well done!" : "Try again!")
                    .font(.headline)
                    .foregroundColor(selectedAnswer == question.correctAnswer ? .green : .red)
            }
        }
    }
}

#Preview {
    NavigationView {
        LessonDetailView(lesson: "Understanding Your Device")
    }
} 
