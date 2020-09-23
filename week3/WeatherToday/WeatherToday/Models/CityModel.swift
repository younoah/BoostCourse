//
//  CityModel.swift
//  WeatherToday
//
//  Created by uno on 2020/09/23.
//

import Foundation

struct City: Codable {
    
    let cityName: String
    let state: Int
    let celsius: Double
    let rainfallProbability: Int
    
    enum Codingkeys: String, CodingKey {
        case state, celsius
        case cityName = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
}
