//
//  MostPopularMovie.swift
//  MovieQuiz
//
//  Created by Mac on 15.06.2024.
//

import Foundation
 
struct MostPopularMovies: Codable {
    let items: [MostPopularMovie]
    let errorMessage: String
    
}

struct MostPopularMovie: Codable{
    let title: String
    let rating: String
    let imageURL: URL
    
    
    
    var resizedImageURL: URL {
        let urlString = imageURL.absoluteString
        let imageUrlString = urlString.components(separatedBy: "._")[0] + "_V0_UX600_.jpg"
        
        guard let newURL = URL(string: imageUrlString) else {
            return imageURL
        }
        return newURL
    }
    
    private enum CodingKeys: String, CodingKey {
               case title = "fullTitle"
               case rating = "imDbRating"
               case imageURL = "image"
               
    }
}
