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
    
    var temperatureString: String {
        return "섭씨 \(celsius)도 / 화씨 \(String(format:"%.1f", celsius * 9/5 + 32))도"
    }
    
    var rainfallProbabilityString: String {
        return "강수확률 \(rainfallProbability)%"
    }
    
    var getWeatherString: String {
        switch state {
        case 10:
            return "sunny"
        case 11:
            return "cloudy"
        case 12:
            return "rainy"
        case 13:
            return "snowy"
        default:
            return "sunny"
        }
    }
    
    var getWeatherKoreanString: String {
        switch state {
        case 10:
            return "맑음"
        case 11:
            return "구름"
        case 12:
            return "비"
        case 13:
            return "눈"
        default:
            return "맑음"
        }
    }
        
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case state, celsius
        case rainfallProbability = "rainfall_probability"
    }
    
}
