import Foundation
import FirebaseFirestore

class ContentManager {
    private let db = Firestore.firestore()
    
    // Function to upload a course to Firestore.
    func uploadCourse(_ course: Course, completion: @escaping (Error?) -> Void) {
        let courseData: [String: Any] = [
            "id": course.id,
            "title": course.title,
            "subtitle": course.subtitle,
            "courseDescription": course.courseDescription,
            "lessons": course.lessons,
            "completedHours": course.completedHours,
            "totalHours": course.totalHours,
            "color": course.color,
            "price": course.price as Any,
            "progress": course.progress  // if you want to store calculated progress
        ]
        
        db.collection("courses").document(course.id).setData(courseData) { error in
            completion(error)
        }
    }
    
    // Function to fetch all courses.
    func fetchCourses(completion: @escaping (Result<[Course], Error>) -> Void) {
        // For demonstration purposes, simulate a network fetch.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Assume Course.samples returns sample courses.
            completion(.success(Course.samples))
        }
    }
    
    // Function to seed courses into Firestore if none exist.
    func seedCoursesIfNeeded(completion: @escaping (Error?) -> Void) {
        db.collection("courses").getDocuments { snapshot, error in
            if let error = error {
                completion(error)
            } else if let documents = snapshot?.documents, documents.isEmpty {
                let batch = self.db.batch()
                for course in Course.samples {
                    let docRef = self.db.collection("courses").document(course.id)
                    let courseData: [String: Any] = [
                        "id": course.id,
                        "title": course.title,
                        "subtitle": course.subtitle,
                        "courseDescription": course.courseDescription,
                        "lessons": course.lessons,
                        "completedHours": course.completedHours,
                        "totalHours": course.totalHours,
                        "color": course.color,
                        "price": course.price as Any,
                        "progress": course.progress
                    ]
                    batch.setData(courseData, forDocument: docRef)
                }
                batch.commit { batchError in
                    completion(batchError)
                }
            } else {
                // Courses already exist; no need to seed.
                completion(nil)
            }
        }
    }
} 