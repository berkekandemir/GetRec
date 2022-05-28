//
//  GamesModel.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/28/22.
//

import Foundation

struct Game: Codable, Hashable {
    let categories, developer, genres, platforms: String
    let price, publisher, title: String
}

typealias Games = [String: Game]
