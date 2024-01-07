//
//  PatientInfoModel.swift
//  MOCA
//
//  Created by SAIL on 26/10/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

//import Foundation
//
//// MARK: - WelcomeElement
//struct PatientInfoModel: Codable {
//    var id, name, age, gender: String?
//    var diagnosis, drug: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name = "Name"
//        case age = "Age"
//        case gender = "Gender"
//        case diagnosis = "Diagnosis"
//        case drug = "Drug"
//    }
//}
//
//typealias Welcome = [PatientInfoModel]


//import Foundation
//
//// MARK: - Welcome
//struct PatientInfoModel: Codable {
//    var id, name, age, gender: String?
//    var phoneNumber, alternateMobileNum, diagnosis, drug: String?
//    var hippocampal: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name = "Name"
//        case age = "Age"
//        case gender = "Gender"
//        case phoneNumber = "Phone number"
//        case alternateMobileNum = "Alternate mobile num"
//        case diagnosis = "Diagnosis"
//        case drug = "Drug"
//        case hippocampal = "Hippocampal"
//        case patientImg = "patient_img"
//    }
//}
//

import Foundation

// MARK: - Welcome
struct PatientInfoModel: Codable {
    let status, message: String
    let data: [PatientData]
}

// MARK: - Datum
struct PatientData: Codable {
    let id, name, age, gender: String
    let phoneNumber, alternateMobileNum, diagnosis, drug: String
    let hippocampal, patientImg: String?

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
        case patientImg = "patient_img"
    }
}
