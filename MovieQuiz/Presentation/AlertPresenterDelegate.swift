//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by Mac on 09.07.2024.
//

import UIKit

protocol AlertPresenterDelegate: AnyObject {
    func startNewGame()
    func sendAlert(alert: UIAlertController)
}
