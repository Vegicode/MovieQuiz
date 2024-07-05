import UIKit

final class MovieQuizViewController: UIViewController,MovieQuizViewControllerProtocol {
    //MARK: - Аутлеты
          @IBOutlet private weak var imageView: UIImageView!
          @IBOutlet private weak var textLabel: UILabel!
          @IBOutlet private weak var counterLabel: UILabel!
          @IBOutlet private weak var questionLabel: UILabel!
          @IBOutlet private weak var noButtonStyle: UIButton!
          @IBOutlet private weak var yesButtonStyle: UIButton!
          @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
          override var preferredStatusBarStyle: UIStatusBarStyle {
               return .lightContent
          }

    
           private var correctAnswers = 0
           private var questionFactory: QuestionFactoryProtocol?
           private var currentQuestion: QuizQuestion?
           private var alertDelegate: MovieQuizViewControllerDelelegate?
           private var statisticService: StatisticServiceProtocol?
           private var alertPresenter =  AlertPresenter()
           private var presenter: MovieQuizPresenter!

     
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styles()
        presenter = MovieQuizPresenter(viewController: self)
        showLoadingIndicator()
      
    }

    func styles(){
            
            textLabel.font = UIFont(name: "YSDisplay-Medium", size: 23)
            
            counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
            
            questionLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
            
            noButtonStyle.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
            yesButtonStyle.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
            imageView.layer.cornerRadius = 20
            imageView.contentMode = .scaleAspectFill
            activityIndicator.color = UIColor.lightGray
        }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        questionLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController (
            title: result.title,
            message: presenter.makeResultsMessage(),
            preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "GameResults"
        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
            guard let self = self else {return}
            
            self.presenter.restartGame()
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func noBorder() {
        imageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
           hideLoadingIndicator()
           
           let model = AlertModel(title: "Ошибка",
                                  message: message,
                                  buttonText: "Попробовать еще раз") { [weak self] in
               guard let self = self else { return }
               self.presenter.restartGame()
           }
           alertDelegate?.show(alertModel: model)
           
       }

    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
           
           presenter.yesButtonClicked()
       }
       
       
       @IBAction private func noButtonClicked(_ sender: UIButton) {
           presenter.noButtonClicked()
       }
       
    
    

}
