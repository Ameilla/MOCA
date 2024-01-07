//
//  GraphModel.swift
//  MOCA
//
//  Created by AMAR on 02/12/23.
//

import Foundation
struct GraphModel: Codable {
    let status, message: String
    let resultData, dateData: [String]
    let id: String
}
