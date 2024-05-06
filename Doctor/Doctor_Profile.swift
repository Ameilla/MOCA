//
//  Doctor_Profile.swift
//  MOCA
//
//  Created by SAIL L1 on 07/10/23.
//

import UIKit

class Doctor_Profile: UIViewController {
    @IBOutlet weak var border: UIImageView!
    
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    
    var doctor_profile: DoctorProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()
//        border.layer.cornerRadius=border.frame.height/2;
        border.layer.masksToBounds=true
        
        
        nameLabel.layer.borderWidth = 1.0
        emailLabel.layer.borderWidth = 1.0
        passwordLabel.layer.borderWidth = 1.0
        designationLabel.layer.borderWidth = 1.0
        PostAPI()
       
    }
    @IBAction func back(_ sender: Any) {
//  navigationController?.popViewController(animated: true)
       for controller in self.navigationController!.viewControllers as Array {
        if controller.isKind(of: Dashboard.self) {
            self.navigationController!.popToViewController(controller, animated: true)
            break
        }
    }
    }
    @IBAction func editBtn(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Update_doctor") as! Update_doctor
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // Call the API to refresh data
            PostAPI()
        }
    func PostAPI() {
        let apiURL = APIList.DoctorProfileApi
        print(apiURL)

        // Prepare POST parameters if needed
        let parameters: [String: String] = [:
            // Add your POST parameters here if required
            // "key1": value1,
            // "key2": value2,
        ]

        APIHandler().postAPIValues(type: DoctorProfileModel.self, apiUrl: apiURL, method: "POST", formData: parameters) { result in
            switch result {
            case .success(let data):
                self.doctor_profile = data

                DispatchQueue.main.async { [self] in
                    self.nameLabel.text = "   \(self.doctor_profile?.name ?? "")"
                    self.emailLabel.text = "   \(self.doctor_profile?.email ?? "")"
                    self.passwordLabel.text = "   \(self.doctor_profile?.password ?? "")"
                    self.designationLabel.text = "   \(self.doctor_profile?.designation ?? "")"

                    let imageDataString = doctor_profile?.image
                    if let imageData = Data(base64Encoded: imageDataString! ),
                       let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.profile_image.image = image
                        }
                    } else {
                        print("Error decoding image data")
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
//        let apiURL = APIList.DoctorProfileApi+""//
//        print(apiURL)
//        APIHandler().getAPIValues(type: DoctorProfileModel.self, apiUrl: apiURL, method: "GET") { result in
//            switch result {
//            case .success(let data):
//                self.doctor_profile = data
//                
//
//                DispatchQueue.main.async { [self] in
//                        self.nameLabel.text = self.doctor_profile?.name
//                        self.emailLabel.text = self.doctor_profile?.email
//                        self.passwordLabel.text = self.doctor_profile?.password
//                        self.designationLabel.text = self.doctor_profile?.designation
//                        
//                        let imageDataString = doctor_profile?.image
//                        if let imageData = Data(base64Encoded: imageDataString! ),
//                           let image = UIImage(data: imageData) {
//                            DispatchQueue.main.async {
//                                self.profile_image.image = image
//                            }
//                        } else {
//                            print("Error decoding image data")
//                        }
//                        
//                        
//                    }
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









//
//self.nameLabel.text = self.doctor_profile?.data?.first.name
//self.emailLabel.text = self.doctor_profile?.email
//self.passwordLabel.text = self.doctor_profile?.password
//self.designationLabel.text = self.doctor_profile?.designation
