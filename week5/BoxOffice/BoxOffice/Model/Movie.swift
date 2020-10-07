//
//  Movie.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import Foundation

struct MovieResponse: Decodable {
    let orderType: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies
        case orderType = "order_type"
    }
}

struct Movie: Codable {
    
    let reservationGrade: Int
    let reservationRate: Double
    let id, title, date: String
    let grade: Int
    let imageURL: String
    let userRating: Double
    
    var tableDetail: String {
        return "평점 : " + String(userRating) + " 예매순위: " + String(reservationGrade) + " 예매율: " + String(format: "%.2f", reservationRate)
    }
    
    var openDate: String {
        return "개봉일 : " + String(date)
    }
    
    var collectionDetail: String {
        return String(reservationGrade) + "위(" + String(format: "%.2f", userRating) + ") / " + String(format: "%.2f", reservationRate) + "%"
    }
    
    var gradeString: String {
        switch grade {
        case 0:
            return "ic_allages"
        case 12:
            return "ic_12"
        case 15:
            return "ic_15"
        case 19:
            return "ic_19"
        default:
            return ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, date, grade
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
        case imageURL = "thumb"
    }
}

struct MovieDetail: Decodable {
    
    let audience, grade: Int
    let actor: String
    let duration, reservationGrade: Int
    let title: String
    let reservationRate, userRating: Double
    let date, director, id: String
    let image: String
    let synopsis, genre: String
    
    var movieGrade: String {
        switch grade {
        case 0:
            return "ic_allages"
        case 12:
            return "ic_12"
        case 15:
            return "ic_15"
        case 19:
            return "ic_19"
        default:
            return ""
        }
    }

    enum CodingKeys: String, CodingKey {
        case audience, grade, actor, duration
        case reservationGrade = "reservation_grade"
        case title
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
        case date, director, id, image, synopsis, genre
    }
}
