//
//  NewMessageStruct.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 10/14/21.
//

import Foundation

struct commentMessage : Codable{
    
    var postId : Int?
    var id : Int?
    var name : String?
    var email : String?
    var body : String?
    
    init(id: Int, body: String){
        self.postId = id
        self.body = body
        self.name = "Mohammed Abu Oudah"
        self.email = "medo.doood2211@gmail.com"
    }
    
}
