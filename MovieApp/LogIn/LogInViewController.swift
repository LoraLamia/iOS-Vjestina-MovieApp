
import UIKit
import PureLayout

class LogInViewController: UIViewController {
    
    private var titleLabel: UILabel!
    private var emailLabel: UILabel!
    private var passwordLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var signInButton: UIButton!
    private var viewModel: LogInViewModel!
    
    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       get {
          return .portrait
       }
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
        styleViews()
    }
    
    private func createViews() {
        titleLabel = UILabel()
        
        emailLabel = UILabel()
        
        passwordLabel = UILabel()
        
        emailTextField = UITextField()
        
        passwordTextField = UITextField()
        
        signInButton = UIButton()
    }
    
    private func layoutViews() {
        view.addSubview(titleLabel)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 80)
        
        view.addSubview(emailLabel)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        emailLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 48)
        
        view.addSubview(emailTextField)
        emailTextField.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 8)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        emailTextField.autoSetDimension(.height, toSize: 48)
        
        view.addSubview(passwordLabel)
        passwordLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passwordLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        passwordLabel.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: 24)
        
        view.addSubview(passwordTextField)
        passwordTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passwordTextField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        passwordTextField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 8)
        passwordTextField.autoSetDimension(.height, toSize: 48)
        
        view.addSubview(signInButton)
        signInButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 48)
        signInButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 32)
        signInButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 32)
        signInButton.autoSetDimension(.height, toSize: 40)
    }
    
    private func styleViews() {
        view.backgroundColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1.0)
        
        titleLabel.text = "Sign in"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        emailLabel.text = "Email address"
        emailLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        emailLabel.textColor = .white
        
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        passwordLabel.textColor = .white
        
        styleTextField(placeholder: "Enter your email", textField: emailTextField)
        styleTextField(placeholder: "Enter your password", textField: passwordTextField)
        
        signInButton.backgroundColor = UIColor(red: 76/255, green: 178/255, blue: 223/255, alpha: 1.0)
        signInButton.layer.cornerRadius = 10
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.titleLabel?.textColor = .white
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private func styleTextField(placeholder: String, textField: UITextField) {
        textField.backgroundColor = UIColor(red: 19/255, green: 59/255, blue: 99/255, alpha: 1.0)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 76/255, green: 178/255, blue: 223/255, alpha: 1.0)]
        )
        textField.layer.borderColor = CGColor(red: 21/255, green: 77/255, blue: 133/255, alpha: 0.5)
        textField.layer.borderWidth = 1
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.setLeftPaddingPoints(16)
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
