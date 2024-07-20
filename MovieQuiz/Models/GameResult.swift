//
//  GameResult.swift
//  MovieQuiz
//
//  Created by Mac on 13.06.2024.
//

import UIKit

struct GameResult: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ currentGame: GameResult) -> Bool {
        self.correct > currentGame.correct
    }
}
