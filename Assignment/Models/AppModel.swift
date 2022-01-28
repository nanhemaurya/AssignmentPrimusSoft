//
//  AppModel.swift
//  Assignment
//
//  Created by SMN Boy on 28/01/22.
//

import Foundation

// MARK: - AppModel
struct AppModel: Codable {
    let status: Bool
    let message: String?
    let data: DataClass
}
