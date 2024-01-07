//
//  Question5Model.swift
//  MOCA
//
//  Created by AMAR on 22/11/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Question5Model: Codable {
    let status, message: String
    let data: [Question5Data]
}

// MARK: - Datum
struct Question5Data: Codable {
    let id, type, ques, option1: String?
        let option2, option3, option4, answer: String?

        enum CodingKeys: String, CodingKey {
            case id
            case type = "Type"
            case ques, option1, option2, option3, option4, answer
        }
    }
