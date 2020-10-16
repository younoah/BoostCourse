//
//  MovieOrderType.swift
//  BoxOffice
//
//  Created by uno on 2020/10/15.
//

import Foundation

class MovieSort {
    static var shared = MovieSort()
    var orderTypeNumber = 0
    var orderTypesString = ["예매율순","큐레이션","개봉일순"]
}
