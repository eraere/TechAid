import Foundation
import SwiftData

@Model
final class LessonContent {
    var id: String
    var lessonId: String
    var audioUrl: String?
    var notes: [Note]
    var exercises: [Exercise]
    
    init(id: String = UUID().uuidString,
         lessonId: String,
         audioUrl: String? = nil,
         notes: [Note] = [],
         exercises: [Exercise] = []) {
        self.id = id
        self.lessonId = lessonId
        self.audioUrl = audioUrl
        self.notes = notes
        self.exercises = exercises
    }
}

@Model
final class Note {
    var id: String
    var content: String
    var timestamp: Date
    
    init(id: String = UUID().uuidString,
         content: String,
         timestamp: Date = Date()) {
        self.id = id
        self.content = content
        self.timestamp = timestamp
    }
}

@Model
final class Exercise {
    var id: String
    var question: String
    var options: [String]
    var correctAnswer: Int
    var userAnswer: Int?
    
    init(id: String = UUID().uuidString,
         question: String,
         options: [String],
         correctAnswer: Int,
         userAnswer: Int? = nil) {
        self.id = id
        self.question = question
        self.options = options
        self.correctAnswer = correctAnswer
        self.userAnswer = userAnswer
    }
} 