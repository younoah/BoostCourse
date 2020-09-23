//
//  FriendModel.swift
//  JsonDataControl
//
//  Created by uno on 2020/09/23.
//

import Foundation

struct Friend : Codable {
    
    struct Address: Codable {
        let country: String
        let city: String
    }
    
    let name: String
    let age: Int
    let addressInfo: Address
    
    var nameAndAge: String {
        return self.name + " (\(self.age))"
    }
    
    var fullAddress: String {
        return self.addressInfo.city + ", " + self.addressInfo.country
    }
    
    enum CodingKeys: String, CodingKey {
        case name, age
        case addressInfo = "address_info"
    }
    
}
