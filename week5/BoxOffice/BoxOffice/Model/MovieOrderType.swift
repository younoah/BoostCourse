//
//  MovieOrderType.swift
//  BoxOffice
//
//  Created by uno on 2020/10/15.
//

import Foundation

class OrderTpye {
    static var shared = OrderTpye()
    var orderTypeNumber: Int?
    var orderTypes = ["예매율순","큐레이션","개봉일순"]
}
