import SwiftUI

struct CoursesView: View {
    @State private var courses: [Course] = []
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading courses...")
                        .padding()
                } else if courses.isEmpty {
                    Text("No courses available.")
                        .padding()
                } else {
                  // List(courses) { course in
                     //  NavigationLink(destination: TechAid.CourseDetailView(course: course)) {
                          // CourseProgressCard(course: course, onTap: {})
                       // }
                    //}
                    // .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Courses")
            .onAppear {
                loadCourses()
            }
        }
    }
    
    private func loadCourses() {
        isLoading = true
        // For demonstration, we simulate fetching courses after 0.5 seconds.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            courses = Course.samples // Ensure Course.samples is available in your Course model
            isLoading = false
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
} 
