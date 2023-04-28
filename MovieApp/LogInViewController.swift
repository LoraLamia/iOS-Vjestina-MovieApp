
import UIKit
import PureLayout

class LogInViewController: UIViewController {
    
    private var titleLabel: UILabel!
    private var emailLabel: UILabel!
    private var passwordLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        createViews()
        defineLayoutForView()
        styleViews()
    }
    
    private func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.text = "Sign in"
        
        emailLabel = UILabel()
        view.addSubview(emailLabel)
        emailLabel.text = "Email address"
        
        passwordLabel = UILabel()
        view.addSubview(passwordLabel)
        passwordLabel.text = "Password"
        
        emailTextField = UITextField()
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField()
        view.addSubview(passwordTextField)
        
        signInButton = UIButton()
        view.addSubview(signInButton)
        
    }
    
    private func defineLayoutForView() {
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 80)
        
        emailLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        emailLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 48)
        
        emailTextField.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 8)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        emailTextField.autoSetDimension(.height, toSize: 48)
        
        passwordLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passwordLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        passwordLabel.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: 24)
        
        passwordTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passwordTextField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        passwordTextField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 8)
        passwordTextField.autoSetDimension(.height, toSize: 48)
        
        signInButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 48)
        signInButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 32)
        signInButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 32)
        signInButton.autoSetDimension(.height, toSize: 40)
    }
    
    private func styleViews() {
        view.backgroundColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1.0)
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        emailLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        emailLabel.textColor = .white
        
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
