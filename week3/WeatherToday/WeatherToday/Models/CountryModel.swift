//
//  CountryModel.swift
//  WeatherToday
//
//  Created by uno on 2020/09/23.
//

import Foundation

struct Country: Codable {
    let koreanName: String
    let assetName: String
    
    var flagName: String {
        return "flag_\(assetName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case koreanName = "korean_name"
        case assetName = "asset_name"
    }
}
