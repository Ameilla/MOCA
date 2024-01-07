//
//  LoginRequest.swift
//  MOCA
//
//  Created by SAIL on 20/10/23.
//

import Foundation

//// MARK: - Welcome
//struct LoginModel: Codable {
//    var status: Bool?
//    var message: String?
//    var data: LoginData?
//}
//
//// MARK: - DataClass
//struct LoginData: Codable {
//    var doctorID, doctorName, doctorEmail, doctorPassword: String?
//    var doctorDesignation: String?
//
//    enum CodingKeys: String, CodingKey {
//        case doctorID = "doctor_id"
//        case doctorName = "doctor_name"
//        case doctorEmail = "doctor_email"
//        case doctorPassword = "doctor_password"
//        case doctorDesignation = "doctor_designation"
//    }
//}


struct LoginModel: Codable {
    let status, message: String
}
