//
//  Comment.swift
//  BoxOffice
//
//  Created by uno on 2020/10/07.
//

import Foundation

struct CommentResponse: Codable {
    let comments: [Comment]
}

struct Comment: Codable {
    
    let id: String
    let rating: Double
    let timestamp: Double
    let writer, movieID, contents: String

    enum CodingKeys: String, CodingKey {
        case id, rating, timestamp, writer
        case movieID = "movie_id"
        case contents
    }
}

struct PostComment: Codable {
    
    let rating: Double
    let writer, movieID, contents: String

    enum CodingKeys: String, CodingKey {
        case rating, writer
        case movieID = "movie_id"
        case contents
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
