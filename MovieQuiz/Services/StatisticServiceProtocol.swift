//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Mac on 06.06.2024.
//

import UIKit





protocol StatisticServiceProtocol {
    var gameCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    
    func store(correct count: Int, total amount: Int)
}

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
}





