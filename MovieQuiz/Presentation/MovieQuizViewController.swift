import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate, AlertPresenterProtocol {
    
    
  
    
    private var currentQuestionIndex = 0
       private var correctAnswers = 0
       private let questionsAmount: Int = 10
       private var questionFactory: QuestionFactoryProtocol?
       private var currentQuestion: QuizQuestion?
       private var alertDelegate: MovieQuizViewControllerDelelegate?
       private var statisticService: StatisticServiceProtocol?
       //@IBOutlet private weak var imageView: UIImageView!
       @IBOutlet private weak var imageView: UIImageView!
       
       // @IBOutlet private weak var textLabel: UILabel!
       @IBOutlet private weak var textLabel: UILabel!
       
       
       //@IBOutlet private weak var counterLabel: UILabel!
       @IBOutlet private weak var counterLabel: UILabel!
       
       //@IBOutlet private weak var questionLabel: UILabel!
       
       @IBOutlet private weak var questionLabel: UILabel!
       
       @IBOutlet private weak var noButtonStyle: UIButton!
       
       @IBOutlet private weak var yesButtonStyle: UIButton!
       
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statisticService = StatisticService()
        
        let questionFactory = QuestionFactory()
        
        questionFactory.setup(delegate: self)
        
        self.questionFactory = questionFactory
        
        
        
        questionFactory.requestNextQuestion()
        
        let alertDelegate = AlertPresenter()
        alertDelegate.alertController = self
        self.alertDelegate = alertDelegate 
        
        
        textLabel.font = UIFont(name: "YSDisplay-Medium", size: 23)
        
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        
        questionLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        
        noButtonStyle.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        yesButtonStyle.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        imageView.layer.cornerRadius = 20
        
        
        
        
      
    }
    
    struct ViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }
    
    
    
   
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        
        guard let currentQuestion = currentQuestion else{
            return
        } // 1
        let givenAnswer = true // 2
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else{
            return
        } // 1
        let givenAnswer = false // 2
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        
    }
    
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
          guard let question = question else{
              return
          }
          currentQuestion = question
          let viewModel = convert(model: question)
          
          DispatchQueue.main.async { [weak self] in
              self?.show(quiz: viewModel)
          }
      }
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        questionLabel.text = step.question
        counterLabel.text = step.questionNumber
        
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel( // 1
            image: UIImage(named: model.image) ?? UIImage(), // 2
            question: model.text, // 3
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)") // 4
        return questionStep
    }
    private func showAnswerResult(isCorrect: Bool) {
        
        if isCorrect {
            correctAnswers += 1
        }
        
        imageView.layer.masksToBounds = true // 1
        imageView.layer.borderWidth = 8 // 2
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else{return}
            self.showNextQuestionOrResults()
            self.imageView.layer.borderColor = UIColor.clear.cgColor
            
        }
    }
    
    
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in // слабая ссылка на self
            guard let self = self else { return }
            
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            
            self.questionFactory?.requestNextQuestion()
            
            
        }
        alert.addAction(action)
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in // слабая ссылка на self
            guard let self = self else { return }
            self.showNextQuestionOrResults()
            
        }
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
     func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            statisticService?.store(correct: correctAnswers, total: questionsAmount)// 1
            let bestGame = statisticService?.bestGame
            let text =
                      """
                      Ваш результат: \(correctAnswers)/\(questionsAmount)
                      Количество сыгранных квизов: \(statisticService?.gamesCount ?? 0)
                      Рекорд: \(statisticService?.bestGame.correct ?? 0))/\(questionsAmount) (\(statisticService?.bestGame.date.dateTimeString ?? ""))%"
                      Средняя точность: \(String(format: "%.2f", statisticService?.totalAccuracy ?? ""))%"
                      """
            let alertModel = AlertModel( // 2
                title: "Этот раунд окончен!",
                message: text,
                buttonText: "Сыграть ещё раз",
                completion: {
                    self.currentQuestionIndex = 1
                    self.correctAnswers = 0
                    self.questionFactory?.requestNextQuestion()
                })
            alertDelegate?.show(alertModel: alertModel)
           correctAnswers = 0
        } else {
            
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
            
        }
        
    }
    
        
    
    

}
