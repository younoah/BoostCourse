//
//  UserInformation.swift
//  ViewTransition
//
//  Created by uno on 2020/09/19.
//

import Foundation

class UserInformation {
  // shared라는 타입프로퍼티를 선언한다.
  // 이 타입 프로퍼티로 인스턴스 1개를 생성해서 할당 하였기 때문에
  // shared라는 타입프로퍼티를 호출하면 항상 똑같은 인스턴스를 사용한다.
  // 보통 이 인스턴스 프로퍼티 명은 암묵적으로 shared, default를 많이 사용한다.
  // 하지만 누구나 shared, default 이걸로 싱글턴으로 데이터를 저장하는것을 알고 있기때문에
  // 보안에 약할수 있어서 프로퍼티명을 잘 정해주는것도 좋을것 같다.
  static let shared: UserInformation = UserInformation()
  
  var name: String?
  var age: String?
}
