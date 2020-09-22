//
//  UserInformation.swift
//  SignUp
//
//  Created by uno on 2020/09/22.
//

import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
        
    var id: String?
    var password: String?
    var introduction: String?
    var phoneNumber: String?
    var birthDate: Date?
}
