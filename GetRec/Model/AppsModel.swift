//
//  AppsModel.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/26/22.
//

import Foundation

struct App: Identifiable, Codable {
    let color: String
    let id: Int
    let name, type: String
}

typealias AppAlias = [String: App]
