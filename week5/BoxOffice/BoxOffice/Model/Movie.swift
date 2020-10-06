//
//  Movie.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import Foundation

struct Movie: Codable {
    
    let reservationGrade: Int
    let reservationRate: Double
    let id: String
    let title: String
    let date: String
    let grade: Int
    let thumb: String
    let userRating: Double
    
    var movieInfo: String {
        return "평점: \(userRating) 예매순위: \(reservationGrade) 예매율: \(reservationRate)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, date, grade, thumb
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
    
}
