//
//  CommenterDataStruct.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 10/3/21.
//

import Foundation

struct CommentData: Codable {
    
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
