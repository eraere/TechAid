import SwiftUI

struct CourseProgressCard: View {
    let course: Course
    var onTap: (() -> Void)? = nil
    
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
                CircularProgressView(progress: course.progress)
            }
            
            // Progress Bar
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(Int(course.progress * 100))% Complete")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(course.completedHours)/\(course.totalHours) hours")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                ProgressView(value: course.progress)
                    .tint(Color(course.color))
            }
            
            // Next Lesson Button
            Button(action: { onTap?() }) {
                HStack {
                    Text("Continue Learning")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
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