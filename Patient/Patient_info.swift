//
//  Patient_info.swift
//  MOCA
//
//  Created by Mahesh on 12/10/23.
//

import UIKit
class Patient_info: UIViewController {
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var diagLabel: UILabel!
    @IBOutlet weak var drugLabel: UILabel!
    @IBOutlet weak var profile_image: UIImageView!
    
    @IBOutlet weak var TakeTestButton: UIButton!
    @IBOutlet weak var TestResultButton: UIButton!
    @IBOutlet weak var DetailsButton: UIButton!
    var id: String?
    var viewPatientinfo: PatientInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id ?? "")
        box.layer.borderWidth = 1.0
        box.layer.borderColor = UIColor.black.cgColor
        box.layer.cornerRadius = 8.0
        PostAPI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        PostAPI()
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
//        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func detailsBtn(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewPatientDetails") as! ViewPatientDetails
        vc.id=id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func resultsbtn(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AllResults") as! AllResults
        vc.id=id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func testBtn(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ques_1") as! ques_1
        vc.id=id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func PostAPI() {
        let apiURL = APIList.PatientInfoApi
        print(apiURL)

        // Prepare POST parameters if needed
        let parameters: [String: Any] = [
            "num":id ?? "262"
            // Add your POST parame62ters here if required
            // "key1": value1,
            // "key2": value2,
        ]

        APIHandler().postAPIValues(type: PatientInfoModel.self, apiUrl: apiURL, method: "POST", formData: parameters) { result in
            switch result {
            case .success(let data):
                self.viewPatientinfo = data
                print(data)
                DispatchQueue.main.async {
                    if let patientData = self.viewPatientinfo?.data.first {
                        self.nameLabel.text = patientData.name
                        self.ageLabel.text = patientData.age
                        self.genderLabel.text = patientData.gender
                        self.diagLabel.text = patientData.diagnosis
                        self.drugLabel.text = patientData.drug

                        // Ensure imageDataString is not nil before attempting to decode
                        let imageDataString = patientData.patientImg
                        if let imageData = Data(base64Encoded: imageDataString!),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                self.profile_image.image = image
                                self.profile_image.contentMode = .scaleAspectFit
                                self.profile_image?.clipsToBounds = true
                            }
                        } else {
                            print("Error decoding image data")
                        }
                    }
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

    
    
    
//    func GetAPI() {
//        let apiURL = APIList.PatientInfoApi + (id ?? "")
//        print(apiURL)
//        
//        APIHandler().getAPIValues(type: PatientInfoModel.self, apiUrl: apiURL, method: "GET") { result in
//            switch result {
//            case .success(let data):
//                self.viewPatientinfo = data
//                print(data)
//                DispatchQueue.main.async {
//                    if let patientData = self.viewPatientinfo?.data.first {
//                        self.nameLabel.text = patientData.name
//                        self.ageLabel.text = patientData.age
//                        self.genderLabel.text = patientData.gender
//                        self.diagLabel.text = patientData.diagnosis
//                        self.drugLabel.text = patientData.drug
//                        
//                        // Ensure imageDataString is not nil before attempting to decode
//                        let imageDataString = patientData.patientImg
//                        if let imageData = Data(base64Encoded: imageDataString! ),
//                           let image = UIImage(data: imageData) {
//                            DispatchQueue.main.async {
//                                self.profile_image.image = image
//                                self.profile_image.contentMode = .scaleAspectFit
//                                   self.profile_image?.clipsToBounds = true
//                            }
//                        } else {
//                            print("Error decoding image data")
//                        }
//                        
//                    }
//                }
//            case .failure(let error):
//                print(error)
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "Warning", message: "Something Went Wrong", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive) { _ in
//                        print("API Error")
//                    })
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//        }
//    }
    
}
//let imageDataString = patientData.patientImg
//// Decode base64-encoded image data
//if let imageData = Data(base64Encoded: imageDataString),
//   let image = UIImage(data: imageData) {
//    // Set the image to the UIImageView
//    self.imageView.image = image
//} else {
//    print("Error decoding image data")
//}
