//
//  BooksModel.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/28/22.
//

import Foundation

struct Book: Codable, Hashable {
    let author, mainTopic, publisher, subtopics: String
        let title: String

        enum CodingKeys: String, CodingKey {
            case author
            case mainTopic = "main-topic"
            case publisher, subtopics, title
        }
}

typealias Books = [String: Book]
