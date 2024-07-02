//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Mac on 06.06.2024.
//

import UIKit


protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    
    func store(correct count: Int, total amount: Int)
}







