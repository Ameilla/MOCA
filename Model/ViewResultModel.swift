//
//  ViewResultModel.swift
//  MOCA
//
//  Created by AMAR on 23/11/23.
//


import Foundation

// MARK: - Welcome
//struct ViewResultModel: Codable {
//    let status, message: String
//    let data: [ViewResultData]
//}
//
//// MARK: - Datum
//struct ViewResultData: Codable {
//    let iD, task1, task2, task3: String
//        let task4, task5, task6, task7: String
//        let image1, image2: String?
//}


struct ViewResultModel: Codable {
    let status, message: String
    let data: [ViewResultData]
}

// MARK: - Datum
struct ViewResultData: Codable {
    let iD, task1, task2, task3: String
    let task4, task5, task6, task7,interpretation, submissionDate, result: String
    let image1, image2: String?

    enum CodingKeys: String, CodingKey {
        case iD, task1, task2, task3, task4, task5, task6, task7, interpretation, result
        case submissionDate = "submission_date"
        case image1, image2
    }
}
