//
//  DashboardModel.swift
//  MOCA
//
//  Created by SAIL on 20/10/23.
//

import Foundation

// MARK: - Welcome
//struct DashboardModel: Codable {
//    var status, message: String?
//    var data: DashData?
//}
//
//// MARK: - Datum
//struct DashData: Codable {
//    var id, name, age, gender: String?
//    var diagnosis: String?
//    var patientImg: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "Name"
//        case age = "Age"
//        case gender = "Gender"
//        case diagnosis = "Diagnosis"
//        case patientImg = "patient_img"
//    }
//}

 //MARK: - Welcome
struct DashboardModel: Codable {
    let status, message: String?
    let data: [DashData]?
}

// MARK: - Datum
struct DashData: Codable {
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


//import Foundation
//
//// MARK: - Welcome
//struct DashboardModel: Codable {
//    let status, message: String
//}
