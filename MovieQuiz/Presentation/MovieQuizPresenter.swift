//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Mac on 03.07.2024.
//

import UIKit

final class MovieQuizPresenter{
    let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    var currentQuestion: QuizQuestion?
    weak var viewController: MovieQuizViewController?

    func convert(model: QuizQuestion) -> QuizStepViewModel {
         QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    @IBAction func yesButtonClicked() {
        
        guard let currentQuestion = currentQuestion else{
            return
        } // 1
        let givenAnswer = true // 2
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    @IBAction func noButtonClicked() {
        guard let currentQuestion = currentQuestion else{
            return
        } // 1
        let givenAnswer = false // 2
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        
    }
}
