//
//  FResult.swift
//  MOCA
//
//  Created by AMAR on 17/11/23.
//

import UIKit

class Results: UIViewController {
    var id: String?
    var img = UIImage()
    var image = UIImage()
    
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var interpretation: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var task7Label: UILabel!
    @IBOutlet weak var task6Label: UILabel!
    @IBOutlet weak var task5Label: UILabel!
    @IBOutlet weak var task4Label: UILabel!
    @IBOutlet weak var task3Label: UILabel!
    @IBOutlet weak var task2Label: UILabel!
    @IBOutlet weak var task1Label: UILabel!
    var task1 = 0
    var task2 = 0
    var task3 = 0
    var task4 = 0
    var task5 = 0
    var task6 = 0
    var task7 = 0
    var result = 0
    var UpdateResults: ResultModel! // Assuming you have a ResultModel class
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id ?? "")
        print(image1!)
        image1.layer.borderWidth = 1.0
        image2.layer.borderWidth = 1.0
        image1.image = img
        image2.image=image
        // Update labels with task results
        print(task1)
        print(task2)
        print(task3)
        print(task4)
        print(task5)
        print(task6)
        print(task7)
        print(result)
        task1Label.text = "\(task1)"
        task2Label.text = "\(task2)"
        task3Label.text = "\(task3)"
        task4Label.text = "\(task4)"
        task5Label.text = "\(task6)"
        task6Label.text = "\(task5)"
        task7Label.text = "\(task7)"
        resultLabel.text="\(result)"
        let number = result
        if number >= 26 && number <= 30 {
            interpretation.text="Normal Cognitive"
        } 
        else if number >= 18 && number <= 25
        {
            interpretation.text="Mild Cognitive impairment"
        }
        else if number >= 10 && number <= 17
        {
            interpretation.text="Moderate Cognitive impairment"
        }
        else {
            interpretation.text="Severe Cognitive impairment"
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    @IBAction func profile(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Patient_info") as! Patient_info
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Add(_ sender: Any) {
        GettAPI()
        
    }
}



extension Results {
    func GettAPI() {
        let apiURL = APIList.AddCommentApi + (id ?? "262")
        print(apiURL)
        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()
        let formData: [String: String] = [
            "Discription": "\(commentTF.text ?? "name")",
        ]
        for (key, value) in formData {
            body.append(contentsOf: "--\(boundary)\r\n".utf8)
            body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8)
            body.append(contentsOf: "\(value)\r\n".utf8)
        }
        // Close the request body
        body.append(contentsOf: "--\(boundary)--\r\n".utf8)
        request.httpBody = body
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle the response
            if let data = data {
                print("Response Data:", String(data: data, encoding: .utf8) ?? "")
            }
            if let error = error {
                print("Error:", error.localizedDescription)
            }
        }
        task.resume()
    }
}

