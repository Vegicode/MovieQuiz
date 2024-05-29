import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate{
   
    private var currentQuestionIndex = 0
    
    private let questionsAmount:Int = 10
    
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    
    
    private var correctAnswers = 0
    
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        let questionFactory = QuestionFactory()
                questionFactory.setup(delegate: self)
                self.questionFactory = questionFactory
     
        
        
        textLabel.font = UIFont(name: "YSDisplay-Medium", size: 23)
                  
                  counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
                  
                  questionLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
                  
                  noButtonStyle.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
                  yesButtonStyle.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
                  imageView.layer.cornerRadius = 20
                  
    }
    
    
    

    
    
    
    // MARK: - QuestionFactoryDelegate
    func didRecevieNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
                return
            }

            currentQuestion = question
            let viewModel = convert(model: question)
        DispatchQueue.main.async {
            [weak self] in
            
            self?.show(quiz: viewModel)
        }
       }
 
    // MARK: - QuestionFactoryDelegate
  //  @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
   // @IBOutlet private weak var textLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    //@IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var counterLabel: UILabel!
    
   // @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    
  //  @IBOutlet weak var noButtonStyle: UIButton!
    @IBOutlet weak var noButtonStyle: UIButton!
    
  //  @IBOutlet weak var yesButtonStyle: UIButton!
    
    @IBOutlet weak var yesButtonStyle: UIButton!
    
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
    
    
  
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
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
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            self.showNextQuestionOrResults()
            self.imageView.layer.borderColor = UIColor.clear.cgColor
            
        }
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 { // 1
            let text = correctAnswers ==   questionsAmount ?
            "Поздравляем, вы ответили на 10 из 10!" :
            "Вы ответили на \(correctAnswers) из 10,  попробуйте ещё раз!"
            let viewModel = QuizResultsViewModel( // 2
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
                show(quiz: viewModel)// идём в состояние "Результат квиза"
        } else { // 2
            
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
            
            
            }
            
            
        }
        
    
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        _ = UIAlertAction(title: result.buttonText, style: .default) { [weak self]_ in
            guard let self = self else { return }
            
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            
            
            
            questionFactory?.requestNextQuestion()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showNextQuestionOrResults()
            }
            
            self.present(alert, animated: true, completion: nil)// попробуйте написать код создания и показа алерта с результатами
        }
    }
    
    
    
}

