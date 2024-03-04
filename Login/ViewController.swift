//
//

import UIKit
class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginbtn: UIButton!
    
    var apiURL = String()
    var login: LoginModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    @IBAction func onlogin(_ sender: Any) {
        //        apiURL = "http://172.17.62.89/API/doctor_validate.php?email=\(emailTF.text ?? "")&password=\(passwordTF.text ?? "")"
        
        if let enteredEmail = emailTF.text, enteredEmail.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Email field is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        } else if let enteredEmail = emailTF.text, !isValidEmail(enteredEmail) {
            let alert = UIAlertController(title: "Alert", message: "Invalid email format", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        } else if let enteredPassword = passwordTF.text, enteredPassword.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Password field is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        } else {
            postAPI()
        }
    }
    
    
    func postAPI() {
        let apiURL = APIList.LogInURL
        let formData = [
            "email": emailTF.text ?? "",
            "password": passwordTF.text ?? ""
        ]
        
        APIHandler().postAPIValues(type: LoginModel.self, apiUrl: apiURL, method: "POST", formData: formData) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let login):
                    print(login)
                    if login.status == "success" {
                        // Login successful
                        self.navigateToDashboard()
                    } else {
                        // Login failed, show an alert
                        self.showAlert(title: "Error", message: login.message ?? "Login failed. Please try again.")
                    }
                case .failure(let error):
                    print(error)
                    // Handle the failure case, show an alert or log the error
                    self.showAlert(title: "Error", message: "Something went wrong. Please try again.")
                }
            }
        }
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func navigateToDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homePageVC = storyboard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
        navigationController?.pushViewController(homePageVC, animated: true)
    }
}
