//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Mac on 15.06.2024.
//

import UIKit

protocol NetworkRouting {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
}


struct NetworkClient {
    
    
    private enum NetworkError: Error {
        case codeError
        
    }
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error{
                    handler(.failure(error))
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                   response.statusCode < 200 || response.statusCode >= 300 {
                    handler(.failure(NetworkError.codeError))
                    return
                }
                guard let data = data else { return }
                handler(.success(data))
                
            }
            
            task.resume()
            
        }
}



