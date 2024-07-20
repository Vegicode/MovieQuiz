//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Mac on 24.05.2024.
//


import UIKit

protocol QuestionFactoryDelegate{
    func didReceiveNextQuestion(question: QuizQuestion?)
       func didLoadDataFromServer() // сообщение об успешной загрузке
       func didFailToLoadData(with error: Error)
    
}
// MARK: - QuestionFactoryDelegate


