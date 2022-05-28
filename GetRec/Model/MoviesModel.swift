//
//  MoviesModel.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/28/22.
//

import Foundation

struct Movie: Codable, Hashable {
    let company, country, director, genre: String
    let star, title, writer, year: String
}

typealias Movies = [String: Movie]
