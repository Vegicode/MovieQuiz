//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Mac on 24.05.2024.
//

import Foundation

protocol QuestionFactoryDelegate{
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
    
}
// MARK: - QuestionFactoryDelegate


