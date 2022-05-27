//
//  AppsModel.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/26/22.
//

import Foundation

struct Appppp: Decodable {
    
    var id: String
    var data: Data
    
    struct Data: Decodable {
        var color: String
        var id: Int
        var name: String
        var type: String
    }
}

struct App: Identifiable, Codable {
    let color: String
    let id: Int
    let name, type: String
}

typealias AppAlias = [String: App]
