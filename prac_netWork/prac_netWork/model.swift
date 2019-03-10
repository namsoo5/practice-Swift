//
//  model.swift
//  prac_netWork
//
//  Created by 남수김 on 09/03/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import Foundation

/*
 
 {
 {
 name: {
 title: "mr",
 first: "håkon",
 last: "skulstad"
 },
 email: "håkon.skulstad@example.com",
 picture: {
 large: "https://randomuser.me/api/portraits/men/28.jpg",
 medium: "https://randomuser.me/api/portraits/med/men/28.jpg",
 thumbnail: "https://randomuser.me/api/portraits/thumb/men/28.jpg"
 }
 }
 
 */

struct APIResponse: Codable {
    let results: [Model]
}

struct Model: Codable {
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
        
        var full: String {
            return self.title.capitalized + ". " + self.first.capitalized + " " + self.last.capitalized
        }
    }
    
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    let name: Name
    let email: String
    let picture: Picture
}


