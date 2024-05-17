import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.font = UIFont(name: "YSDisplay-Medium", size: 23)
        
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        
        questionLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        
        noButtonStyle.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        yesButtonStyle.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        
        
        
        
        
        if let firstQuestion = questions.first {
            let viewModel = convert(model: firstQuestion)
            show(quiz: viewModel)
        }
        
        
    }
    
    struct ViewModel {
      let image: UIImage
      let question: String
      let questionNumber: String
    }
    
    struct QuizStepViewModel {
      let image: UIImage
      let question: String
      let questionNumber: String
    }

    struct QuizResultsViewModel {
      let title: String
      let text: String
      let buttonText: String
    }
    
    struct QuizQuestion {
     
      let image: String
      
      let text: String
     
      let correctAnswer: Bool
    }
    
    private let questions: [QuizQuestion] = [
            QuizQuestion(
                image: "The Godfather",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "The Dark Knight",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "Kill Bill",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "The Avengers",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "Deadpool",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "The Green Knight",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "Old",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: "The Ice Age Adventures of Buck Wild",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: "Tesla",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: "Vivarium",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false)
        ]
    
    
  
       private var currentQuestionIndex = 0
       
       
       private var correctAnswers = 0
       
    
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var textLabel: UILabel!
    
    
    @IBOutlet private weak var counterLabel: UILabel!
    
    @IBOutlet private weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var noButtonStyle: UIButton!
    
    @IBOutlet weak var yesButtonStyle: UIButton!
    
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
       
        let currentQuestion = questions[currentQuestionIndex] // 1
            let givenAnswer = true // 2
            
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex] // 1
            let givenAnswer = false // 2
            
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        
    }
    
   
    
   
    private func show(quiz step: QuizStepViewModel) {
      imageView.image = step.image
      textLabel.text = step.question
      counterLabel.text = step.questionNumber
      
    }

    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel( // 1
            image: UIImage(named: model.image) ?? UIImage(), // 2
            question: model.text, // 3
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)") // 4
        return questionStep
    }
    private func showAnswerResult(isCorrect: Bool) {
        
        if isCorrect {
            correctAnswers += 1
        }
        
        imageView.layer.masksToBounds = true // 1
        imageView.layer.borderWidth = 8 // 2
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor 
        imageView.layer.cornerRadius = 20
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        
           self.showNextQuestionOrResults()
            self.imageView.layer.borderColor = .none
    
        }
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 { // 1
            let text = "Ваш результат: \(correctAnswers)/10" // 1
                   let viewModel = QuizResultsViewModel( // 2
                       title: "Этот раунд окончен!",
                       text: text,
                       buttonText: "Сыграть ещё раз")
                   show(quiz: viewModel)// идём в состояние "Результат квиза"
        } else { // 2
            
            currentQuestionIndex += 1
            
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            
            
            show(quiz: viewModel)
            
        }
        
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
                title: result.title,
                message: result.text,
                preferredStyle: .alert)
            
            let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                
                let firstQuestion = self.questions[self.currentQuestionIndex]
                let viewModel = self.convert(model: firstQuestion)
                self.show(quiz: viewModel)
            }
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)// попробуйте написать код создания и показа алерта с результатами
    }
}
