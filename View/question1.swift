//
//  question1.swift
//  MOCA
//
//  Created by AMAR on 30/10/23.
//

import UIKit

class question1: UIViewController {
    
    @IBOutlet weak var quesLabel: UILabel!
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet var optionButtons: [UIButton]!
    var QuestionTrial1 : QuestionModel?
    var selectedOption: String?
    var correctAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAPI()
    }
    func GetAPI() {
        let apiURL = APIList.QuestionsApi// You're using "143" as a placeholder, update it with the actual patient ID you want to fetch.
        print(apiURL)
        APIHandler().getAPIValues(type: QuestionModel.self, apiUrl: apiURL, method: "GET") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.QuestionTrial1 = data
                    let questionIndex = 3
                    let question = self.QuestionTrial1?.questions[questionIndex]
                    self.quesLabel.text = question?.question
                    self.optionButtons[0].setTitle(question?.options[0] ?? "", for: .normal)
                    self.optionButtons[1].setTitle(question?.options[1] ?? "", for: .normal)
                    self.optionButtons[2].setTitle(question?.options[2] ?? "", for: .normal)
                    self.optionButtons[3].setTitle(question?.options[3] ?? "", for: .normal)
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Warning", message: "Something Went Wrong", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive) { _ in
                        print("API Error")
                    })
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        // Deselect all buttons
        for button in optionButtons {
            button.isSelected = false
        }
        // Select the tapped button
        sender.isSelected = true
        // Store the selected option
        selectedOption = sender.title(for: .normal)
    }
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let selectedOption = selectedOption, let correctAnswer = self.QuestionTrial1?.questions[3].answer else {
            // No option selected or question data not available
            print("Please select an option.")
            return
        }
        print("Selected Option: \(selectedOption)")
            print("Correct Answer: \(correctAnswer)")
        if selectedOption == correctAnswer{
            // Correct option selected
            print("Correct option selected.")
        } else {
            // Incorrect option selected
            print("Incorrect.")
        }
    }


}
