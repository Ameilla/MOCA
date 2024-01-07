//
//  Question4Model.swift
//  MOCA
//
//  Created by AMAR on 22/11/23.
//



import Foundation

// MARK: - Welcome
struct Question4Model: Codable {
    let status, message: String
    let data: [Question4Data]
}

// MARK: - Datum
struct Question4Data: Codable {
    let id, type, ques, option1: String
        let option2, option3, option4, answer: String
        let quesContent: String?

        enum CodingKeys: String, CodingKey {
            case id
            case type = "Type"
            case ques, option1, option2, option3, option4, answer
            case quesContent = "ques_content"
        }
}

