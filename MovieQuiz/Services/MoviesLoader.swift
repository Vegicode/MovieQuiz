//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Mac on 15.06.2024.
//

import UIKit



protocol MoviesLoading{
    func loadMovies(handler: @escaping (Result<MostPopularMovies,Error>) -> Void)
}

struct MoviesLoader: MoviesLoading {
    
    private let networkClient = NetworkClient()
    
    private var mostPopularMoviesUrl : URL {
        guard let url = URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf") else {
            preconditionFailure("Failure")
        }
        return url
    }
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, any Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            
            switch result {
            case .success(let data):
                do{
                    let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                    handler(.success(mostPopularMovies))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
            
        }
    }
}


