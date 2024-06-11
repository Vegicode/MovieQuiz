//
//  StaticSerivce.swift
//  MovieQuiz
//
//  Created by Mac on 10.06.2024.
//

import UIKit

final class StatisticService: StatisticServiceProtocol {
    
    init(correctAnswers: Int) {
        self.correctAnswers = correctAnswers
    }
    
    private let storage = UserDefaults()

    var totalAccuracy: Double {
        let total = storage.integer(forKey: Keys.total.rawValue)
        let correct = storage.integer(forKey: Keys.correct.rawValue)
        return Double(100) * Double(correct) / Double(total)
        }
        

    
    
    private enum Keys: String{
        case correct
        case bestGame
        case gamesCount
        case date
        case total
    }
    
    var correct: Int{
        get{
            storage.integer(forKey: Keys.correct.rawValue)
        }
        set{
            storage.set(newValue, forKey: Keys.correct.rawValue)
        }
    }
    
    var total: Int{
        get{
            storage.integer(forKey: Keys.total.rawValue)
        }
        set{
            storage.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    

    var gameCount: Int {
        
        get {
            
            storage.integer(forKey: Keys.gamesCount.rawValue)
            
        }
        
        set{
            
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
            
        }

    }
    
    
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey: Keys.total.rawValue)
            let date = storage.integer(forKey: Keys.date.rawValue)
            return GameResult (correct: correct, total: total, date: Date())
        }
        
        set{
            storage.set(newValue.correct, forKey: Keys.correct.rawValue)
            storage.set(newValue.total, forKey: Keys.total.rawValue)
            storage.set(newValue.date, forKey: Keys.date.rawValue)
        }
    }
    private var correctAnswers: Int = 0
    
    func store(correct count: Int, total amount: Int) {
        correct = count
        total += count
        gameCount += 1
        
        
        let newResult = GameResult(correct: count, total: amount, date: Date())
        if newResult.isBetterThan(bestGame) {
            bestGame = newResult
        }
       
    }
    

}
