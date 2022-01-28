//
//  DataModels.swift
//  Assignment
//
//  Created by SMN Boy on 28/01/22.
//

import Foundation

enum AppDataEnum {
    case toolbar
    case even
    case odd
}

struct CollectionViewData {
    let data: Any
    let appDataEnum: AppDataEnum
}

struct UserData {
    let imageUrl: String
    let name: String
}
