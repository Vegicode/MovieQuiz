import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    
    //MARK: - Аутлеты
          @IBOutlet private weak var imageView: UIImageView!
          @IBOutlet private weak var textLabel: UILabel!
          @IBOutlet private weak var counterLabel: UILabel!
          @IBOutlet private weak var questionLabel: UILabel!
          @IBOutlet private weak var noButtonStyle: UIButton!
          @IBOutlet private weak var yesButtonStyle: UIButton!
          @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
          private var presenter: MovieQuizPresenter!

          override var preferredStatusBarStyle: UIStatusBarStyle {
               return .lightContent
          }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styles()
        presenter = MovieQuizPresenter(viewController: self)
        activityIndicator.hidesWhenStopped = true
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

    func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderColor = UIColor.clear.cgColor
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        questionLabel.text = step.question
        changeStateButtons(isEnabled: true)
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        imageView.layer.cornerRadius = 20
    }
    
    func showLoadingIndicator() {
        activityIndicator.color = .black // серый индикатор на сером фоне imageview не видно
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func presentAlert(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20.0)
        textLabel.font = UIFont(name: "YSDisplay-Bold", size: 23.0)
        noButtonStyle.isExclusiveTouch = true
        yesButtonStyle.isExclusiveTouch = true
        imageView.layer.cornerRadius = 20
        noButtonStyle.layer.cornerRadius = 15
        yesButtonStyle.layer.cornerRadius = 15
    }
    
    private func changeStateButtons(isEnabled: Bool) {
        noButtonStyle.isEnabled = isEnabled
        yesButtonStyle.isEnabled = isEnabled
        noButtonStyle.backgroundColor = isEnabled ? UIColor.white : UIColor.gray
        yesButtonStyle.backgroundColor = isEnabled ? UIColor.white : UIColor.gray
    }
    
    // MARK: - IB Actions
    @IBAction private func noButtonClicked(_ sender: Any) {
        changeStateButtons(isEnabled: false)
        presenter.noButtonClicked()
    }
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        changeStateButtons(isEnabled: false)
        presenter.yesButtonClicked()
    }
}
