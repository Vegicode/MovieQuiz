//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Mac on 28.05.2024.
//

import UIKit


class AlertPresenter: MovieQuizViewControllerDelelegate  {
 
    weak var alertController: AlertPresenterProtocol?
       
       func show(alertModel: AlertModel) {
           let alert = UIAlertController(
                   title: alertModel.title,
                   message: alertModel.message,
                   preferredStyle: .alert)
           
           let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
               alertModel.completion()
           }
           
           alert.addAction(action)
           alertController?.present(alert, animated: true)
          
       }
    
}

