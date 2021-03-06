//
//  friend.swift
//  prac_Json
//
//  Created by 남수김 on 12/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import Foundation

/*
 {
 "name":"하나",
 "age":22,
 "address_info": {
 "country":"대한민국",
 "city":"울산"
 }
 }
 */

//struct Friend: Codable {
//
//    struct Address: Codable {
//        let country: String
//        let city: String
//    }
//    let name: String
//    let age: Int
//    let address_info: Address
//}

struct Friend: Codable {
    
    struct Address: Codable {
        let country: String
        let city: String
    }
    let name: String
    let age: Int
    let addressInfo: Address
    
    var nameAndAge: String {   //값을 이용해서 원하는 형태로 쓸수있음
        return self.name + "(\(self.age))"
    }
    
    var fullAddress: String {
        return self.addressInfo.city + ", " + self.addressInfo.country
    }
    
    
    //키값 바꾸고싶은것만 값할당해주기
    enum CodingKeys: String, CodingKey {
        case name, age
        case addressInfo = "address_info"    //address_info 키값이 addressInfo로 변경
    }
}
