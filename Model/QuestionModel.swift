// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
//
import Foundation

// MARK: - Welcome
struct QuestionModel: Codable {
    let questions: [Question]
}

// MARK: - Question
struct Question: Codable {
    let id, question, type, quesContent: String
    let options: [String]
    let answer: String

    enum CodingKeys: String, CodingKey {
        case id, question, type
        case quesContent = "ques_content"
        case options, answer
    }
}



