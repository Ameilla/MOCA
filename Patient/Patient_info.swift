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
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: Dashboard.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
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
        let vc = storyBoard.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
        vc.id=id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func PostAPI() {
        let apiURL = APIList.PatientInfoApi
        print(apiURL)
        
        // Prepare POST parameters if needed
        let parameters: [String: Any] = [
            "num":id ?? "262"
            
        ]
        
        APIHandler().postAPIValues(type: PatientInfoModel.self, apiUrl: apiURL, method: "POST", formData: parameters) { result in
            switch result {
            case .success(let data):
                self.viewPatientinfo = data
                //                print(data)
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
                                self.profile_image.contentMode = .scaleToFill
                                self.profile_image?.clipsToBounds = true
                                self.profile_image.layer.cornerRadius = self.profile_image.frame.height / 2
                                
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
}
