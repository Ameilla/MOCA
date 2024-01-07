//
//  trashModel.swift
//  MOCA
//
//  Created by AMAR on 11/12/23.
//

import Foundation
struct trashModel: Codable {
    let status, message: String?
    let data1: [Dash_Data]?
}

// MARK: - Datum
struct Dash_Data: Codable {
    let id, name, age, gender: String?
    let diagnosis, patientImg: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "Name"
        case age = "Age"
        case gender = "Gender"
        case diagnosis = "Diagnosis"
        case patientImg = "patient_img"
    }
}
