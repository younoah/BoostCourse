//
//  Singleton.swift
//  BoxOffice
//
//  Created by uno on 2020/10/19.
//

import Foundation

class CurrentMovieInfo {
    static let shared = CurrentMovieInfo()
    
    var movieID: String?
    var movieName: String?
    var movieGrade: String?
}

class MovieSort {
    static var shared = MovieSort()
    var orderTypeNumber = 0
    var orderTypesString = ["예매율순","큐레이션","개봉일순"]
}
