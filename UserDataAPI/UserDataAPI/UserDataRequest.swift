//
//  UserDataRequest.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 9/20/21.
//

import Foundation

struct UserDataRequest{
    
    enum UserDataError: Error {
        case noDataAvaliable
        case canNotProccessData
    }
    
    let resourceURL : URL
    
    init() {
        
        guard let resourceURL = URL(string: "https://jsonplaceholder.typicode.com/posts") else { fatalError() }
        
        self.resourceURL = resourceURL

    }
    
    
    func returnData(completion: @escaping(Result<[UserData], UserDataError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            
            guard let jsonData = data else{
                completion(.failure(.noDataAvaliable))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let products = try decoder.decode([UserData].self, from: jsonData)
                completion(.success(products))
            }catch{
                completion(.failure(.canNotProccessData))
            }
            
        }
        
        dataTask.resume()
    }
}
