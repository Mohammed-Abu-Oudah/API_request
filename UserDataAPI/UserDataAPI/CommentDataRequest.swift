//
//  CommentDataRequest.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 10/3/21.
//

import Foundation

struct CommentDataRequest {

    enum CommentDataError: Error {
        case commentCannotBeRequested
        case commentDataCannotBeProcessed
    }
    
    // Here are two variables for the postId and the commentId
    var commentId: Int!

    
    var commentURL: URL

    
    init(forPostId postId : Int){
        
        guard let commentURL = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(String(describing: postId))") else {fatalError()}
        
        self.commentURL = commentURL
        
        
    }
    
    func returnCommentData(completion: @escaping(Result<[CommentData], CommentDataError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: commentURL) { data, _, _ in
            
            guard let jsonData = data else{
                completion(.failure(.commentCannotBeRequested))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let products = try decoder.decode([CommentData].self, from: jsonData)
                completion(.success(products))
            }catch{
                completion(.failure(.commentDataCannotBeProcessed))
            }
            
        }
        
        dataTask.resume()
    }
    
}
