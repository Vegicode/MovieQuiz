//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Mac on 24.05.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    
}
// MARK: - QuestionFactoryDelegate


