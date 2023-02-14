//
//  LogInViewController.swift
//  Navigation
//
//  Created by Suharik on 23.03.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
import RealmSwift


class LogInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var delegate: LoginViewControllerDelegate!
    var items: Results<AuthModel>?
    var viewModel = ProfileViewModel()
    
    private var isUserExists: Bool? {
        willSet {
            if newValue! {
                logInButton.setTitle("loginTitle".localized, for: .normal)
                registrationButton.setTitle("registrTitle".localized, for: .normal)
                
            } else {
                logInButton.setTitle("regTitle".localized, for: .normal)
                registrationButton.setTitle("logTitle".localized, for: .normal)
            }
        }
    }
    
    private lazy var logInScrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "1024")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .labelBackColor
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton (
            title: "",
            titleColor: .textColor,
            backColor: UIColor.init(named: "Color")!,
            backImage: UIImage(named: "blue_pixel") ?? UIImage()
        )
        return button
    }()
    
    lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(switchLogin), for: .touchUpInside)
        return button
    }()
    
    public lazy var loginTextField: UITextField = {
        let textField = logPassTextField(placeholder: "emailText".localized, secure: false)
        let icon = UIImageView(image: UIImage(systemName: "person.fill"))
        icon.tintColor = .textColor
        textField.backgroundColor = .labelBackColor
        textField.leftView = textFieldIcon(subView: icon)
        textField.addTarget(self, action: #selector(logInButtonAlpha), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = logPassTextField(placeholder: "passText".localized, secure: true)
        let icon = UIImageView(image: UIImage(systemName: "lock.fill"))
        icon.tintColor = .textColor
        textField.leftView = textFieldIcon(subView: icon)
        textField.backgroundColor = .labelBackColor
        textField.addTarget(self, action: #selector(logInButtonAlpha), for: .editingChanged)
        return textField
    }()
    
    private lazy var authButton: CustomButton = {
        let button = CustomButton (
            title: "authButton".localized,
            titleColor: .textColor,
            backColor: .buttonColor,
            backImage: UIImage()
        )
        return button
    }()
    
    // MARK: - Main Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "authTitle".localized
        self.tabBarController?.tabBar.isHidden = true
        
        let loginFactory = MyLoginFactory()
        self.delegate = loginFactory.returnLoginInspector()
        view.backgroundColor = .backgroundColor
        authButton.setTitleColor(.textColor, for: .normal)
        
        isUserExists = false
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        setupContentViews()
        hideKeyboardWhenTappedAround()
        
        authButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.authButtonTapped()
        }
        
        logInButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.logInButtonPressed()
        }
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if self.isUserExists! {
                self.pushProfileViewController()
            }
        }
        
        UserValidation.shared.completion = { [weak self] message in
            guard let self = self else { return }
            self.present(self.showAlert(message) , animated: true, completion: nil)
        }
        
    }
    
    private func setupContentViews() {
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(textFieldsStackView)
        contentView.addSubview(logInButton)
        contentView.addSubview(registrationButton)
        contentView.addSubview(authButton)
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        setupLoginLayouts()
    }
    
    private func setupLoginLayouts() {
        
        logInScrollView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.centerX.centerY.equalTo(logInScrollView)
        }
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(170)
            make.width.height.equalTo(100)
            make.centerX.equalTo(contentView)
        }
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(80)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(100)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
        
        authButton.snp.makeConstraints{ make in
            make.top.equalTo(registrationButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Added Functions
    
    private func authButtonTapped() {
                LocalAuthorizationService.shared.authorizeIfPossible { [weak self] success, error  in
                    guard let self = self else { return }
                    if success {
                        self.pushProfileViewController()
                    } else if let error = error {
                        self.showErrorAlert("errorAlertMessage".localized + error.localizedDescription)
                    }
                }
        //self.pushProfileViewController()
    }
    
    @objc private func switchLogin() {
        isUserExists!.toggle()
    }
    
    private func logInButtonPressed(){
//                UserDefaults.standard.setValue(false, forKey: "isManuallySignOut")
//                guard
//                    //let delegate = self.delegate,
//                    let login = loginTextField.text,
//                    let password = passwordTextField.text
//                else { return }
//                let authData = AuthModel(value: [login, password])
//                do {
//                    let realm = try Realm()
//                    try realm.write { realm.add(authData) }
//                } catch let error {
//                    print ("⛔️ REALM ERROR: \(error.localizedDescription)")
//                }
//
//                toAuthentication(login, password)
        self.pushProfileViewController()
    }
    
    private func toAuthentication (_ login: String, _ password: String) {
        guard let delegate = self.delegate else { return }
        DispatchQueue.main.async {
            delegate.signing(signType: self.isUserExists! ? .signIn : .signUp, log: login, pass: password)
            
        }
    }
    
    @objc func logInButtonAlpha() {
        if loginTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            logInButton.alpha = 1.0
            logInButton.isEnabled = true
            registrationButton.alpha = 1.0
            registrationButton.isEnabled = true
        } else {
            logInButton.alpha = 0.5
            logInButton.isEnabled = false
            registrationButton.alpha = 1.0
            registrationButton.isEnabled = true
        }
    }
    
    private func logPassTextField(placeholder: String, secure: Bool) ->  UITextField {
        let logPassTextField = UITextField()
        logPassTextField.leftViewMode = .always
        logPassTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: logPassTextField.frame.height))
        logPassTextField.placeholder = placeholder
        logPassTextField.layer.borderColor = UIColor.lightGray.cgColor
        logPassTextField.layer.borderWidth = 0.25
        logPassTextField.textColor = .black
        logPassTextField.font = UIFont.systemFont(ofSize: 16)
        logPassTextField.autocorrectionType = .no
        logPassTextField.autocapitalizationType = .none
        logPassTextField.keyboardType = .emailAddress
        logPassTextField.returnKeyType = .done
        logPassTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        logPassTextField.isSecureTextEntry = secure
        return logPassTextField
    }
    
    private func showAlert(_ description: String) -> UIAlertController {
        let alertController = UIAlertController(title: "loginAlertTitle".localized, message: description, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "alertAcceptTitle".localized, style: .default) { _ in }
        alertController.addAction(acceptAction)
        return alertController
    }
    
    func showErrorAlert(_ string: String) {
        let alert = UIAlertController(title: "errorAlertTitle".localized, message: "errorAlertMessage".localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "alertAcceptTitle".localized, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func pushProfileViewController() {
        let currentUserService = TestUserService()
        let profileViewController = ProfileViewController(userService: currentUserService, name: loginTextField.text!, viewModel: viewModel)
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldIcon (subView: UIView) -> UIView {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(subView)
        subView.center = leftView.center
        return leftView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard !UserDefaults.standard.bool(forKey: "isManuallySignOut") else { return }
        
        do {
            try Auth.auth().signOut()
            let realm = try Realm()
            self.items = realm.objects(AuthModel.self)
            
        } catch { print ("⛔️ REALM AUTH ERROR: \(error.localizedDescription)") }
        
        if let item = self.items?.first {
            toAuthentication(item.login, item.password)
        }
    }
    
    @objc func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            logInScrollView.contentOffset.y = keyboardRectangle.height - (logInScrollView.frame.height - logInButton.frame.maxY) + 16
        }
    }
    
    @objc func keyboardHide(_ notification: Notification){
        logInScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extensions

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}



