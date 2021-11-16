//
//  PostMessage.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 10/7/21.
//

import Foundation

final class PostMessage : Codable{
    var userId : Int?
    var id : Int?
    var title : String?
    var body : String?
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
