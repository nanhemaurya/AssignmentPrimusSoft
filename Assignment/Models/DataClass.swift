//
//  DataClass.swift
//  Assignment
//
//  Created by SMN Boy on 28/01/22.
//

import Foundation


// MARK: - DataClass
struct DataClass: Codable {
    let users: [User]
    let has_more: Bool
}
