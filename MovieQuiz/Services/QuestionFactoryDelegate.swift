//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Mac on 24.05.2024.
//

import Foundation

weak var delegate: QuestionFactoryDelegate?

protocol QuestionFactoryDelegate: AnyObject {
    func didRecevieNextQuestion(question: QuizQuestion?)
}

// MARK: - QuestionFactoryDelegate


