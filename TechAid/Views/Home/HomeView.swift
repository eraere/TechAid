import SwiftUI
import SwiftData


// /**
// class AuthenticationManager: ObservableObject {
//     @Published var isAuthenticated: Bool = false
//     var currentUser: User? = nil
// }
// **/

struct HomeView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var courses: [Course] = []
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if authManager.isAuthenticated {
                    Text("Welcome, \(authManager.currentUser?.name ?? "User")!")
                        .font(.title)
                        .padding()
                    
                    if isLoading {
                        ProgressView("Loading courses...")
                            .padding()
                    } else {
                        Text("Courses loaded")
                            .padding()
                    }
                } else {
                    Text("Please sign in.")
                }
            }
            .navigationTitle("Home")
            .onAppear(perform: loadCourses)
        }
    }
    
    private func loadCourses() {
        isLoading = true
        // For demonstration, we simulate fetching courses after a 0.5 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            courses = Course.samples  // Ensure Course.samples is defined in your Course model.
            isLoading = false
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthenticationManager())
    }
}
