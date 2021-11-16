//
//  CommentAPIPostRequest.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 10/14/21.
//

import Foundation

enum CommentAPIPostErr : Error{
    case responseProblem
    case decondingProblem
    case encodingProblem
}

struct CommentAPIPostRequest {
    let resourceURL: URL
    
    init() {
        let resourceString = "https://jsonplaceholder.typicode.com/posts"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func comment(_ messageToSave: CommentData, completion: @escaping(Result<CommentData, CommentAPIPostErr>) -> Void){
        do{
            var urlPostRequest = URLRequest(url: resourceURL)
            urlPostRequest.httpMethod = "POST"
            urlPostRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // Now what we need to do is to define the httpBody of our url request and this is going to include our messageToSave as json code.
            // And here things could go wrong so we should add try.
            urlPostRequest.httpBody = try JSONEncoder().encode(messageToSave)
            
            // Now we will make the request using the dataTask.
            // From the dataTask we will recieve back the data, the response and Error which we won't give it that much of attention.
            let dataTask = URLSession.shared.dataTask(with: urlPostRequest) {data, response, _ in
                // We have to check that we have recieved a response so we will check that the response status is 200
                guard let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode == 201,
                      let jsonData = data else{
                    completion(.failure(.responseProblem))
                    return
                }
                // But if we get the information that we need we will do here another do try to avoide errors.
                do{
                    // See here why we used the Codable for the message type because if we used the Encodable we wouldn't be able to use the decoder.
                    let messageData = try JSONDecoder().decode(CommentData.self, from: jsonData)
                    completion(.success(messageData))
                }catch{
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
    
}

