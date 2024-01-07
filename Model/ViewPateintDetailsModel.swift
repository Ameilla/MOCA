//
//  ViewPateintDetailsModel.swift
//  MOCA
//
//  Created by AMAR on 25/10/23.
//

import Foundation

// MARK: - Welcome
struct ViewPateintDetailsModel: Codable {
    let status, message: String
    let data: [ViewPateintData]?
}

// MARK: - Datum
struct ViewPateintData: Codable {
    let id, name, age, gender: String
        let phoneNumber, alternateMobileNum, diagnosis, drug: String
        let hippocampal, discription, patientImg, mriBefore: String
        let mriAfter: String

        enum CodingKeys: String, CodingKey {
            case id
            case name = "Name"
            case age = "Age"
            case gender = "Gender"
            case phoneNumber = "Phone number"
            case alternateMobileNum = "Alternate mobile num"
            case diagnosis = "Diagnosis"
            case drug = "Drug"
            case hippocampal = "Hippocampal"
            case discription = "Discription"
            case patientImg = "patient_img"
            case mriBefore = "mri_before"
            case mriAfter = "mri_after"
        }
    }
