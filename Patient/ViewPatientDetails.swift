import UIKit

class ViewPatientDetails: UIViewController {
    
    
    @IBOutlet weak var mri_before: UIImageView!
    @IBOutlet weak var mri_after: UIImageView!
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var AgeLabel: UILabel!
    @IBOutlet weak var GenderLabel: UILabel!
    @IBOutlet weak var Phone_no_Label: UILabel!
    @IBOutlet weak var Alter_ph_no_Label: UILabel!
    @IBOutlet weak var DrubLabel: UILabel!
    @IBOutlet weak var DiagnosisLabel: UILabel!
    @IBOutlet weak var HippoLabel: UILabel!
    @IBOutlet weak var DiscriptionLabel: UILabel!
    @IBOutlet weak var UpdateButton: UIButton!
    @IBOutlet weak var DeleteButton: UIButton!
    
    var id: String?
    var viewPatient: ViewPateintDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAPI()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mriViewTapped))
            mri_before.isUserInteractionEnabled = true
            mri_before.addGestureRecognizer(tapGestureRecognizer)
        
        let GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mriAfterViewTapped))
            mri_after.isUserInteractionEnabled = true
            mri_after.addGestureRecognizer(GestureRecognizer)
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            GetAPI()
        }

    @objc func mriViewTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let imageDetailVC = storyboard.instantiateViewController(withIdentifier: "mri_ImageViewVC") as? mri_ImageViewVC {
            // Pass the MRI image data to the destination view controller here
            if let imageData = mri_before.image?.pngData() {
                imageDetailVC.img = UIImage(data: imageData)!
            }
            navigationController?.pushViewController(imageDetailVC, animated: true)
        }
    }
    @objc func mriAfterViewTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let imageDetailVC = storyboard.instantiateViewController(withIdentifier: "mri_ImageViewVC") as? mri_ImageViewVC {
            // Pass the MRI image data to the destination view controller here
            if let imageData = mri_after.image?.pngData() {
                imageDetailVC.img = UIImage(data: imageData)!
            }
            navigationController?.pushViewController(imageDetailVC, animated: true)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: Patient_info.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Patient", message: "Are you sure you want to delete this patient?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deletePatient()
        })
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UpdatePatient") as! UpdatePatient
        self.navigationController?.pushViewController(vc, animated: true)
        vc.id=id
    }
    func GetAPI() {
        let apiURL = APIList.ViewPatientApi
        print(apiURL)
        // Prepare POST parameters if needed
        let parameters: [String: Any] = [
            "num": id ?? "262"
            
        ]
        APIHandler().postAPIValues(type: ViewPateintDetailsModel.self, apiUrl: apiURL, method: "POST", formData: parameters) { result in
            switch result {
            case .success(let data):
                self.viewPatient = data
//                print(data)
                DispatchQueue.main.async {
                    if let patientData = self.viewPatient?.data?.first {
                        self.NameLabel.text = patientData.name
                        self.AgeLabel.text = patientData.age
                        self.GenderLabel.text = patientData.gender
                        self.Phone_no_Label.text = patientData.phoneNumber
                        self.Alter_ph_no_Label.text = patientData.alternateMobileNum
                        self.DrubLabel.text = patientData.drug
                        self.DiagnosisLabel.text = patientData.diagnosis
                        self.HippoLabel.text = patientData.hippocampal
                        self.DiscriptionLabel.text = patientData.discription

                        // Ensure imageDataString is not nil before attempting to decode
                        let imageDataString = patientData.patientImg
                        if let imageData = Data(base64Encoded: imageDataString),
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
                        let imageDataString2 = patientData.mriBefore
                        if let imageData = Data(base64Encoded: imageDataString2),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                self.mri_before.image = image
                            }
                        } else {
                            print("Error decoding image data")
                        }
                        let imageDataString3 = patientData.mriAfter
                        if let imageData = Data(base64Encoded: imageDataString3),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                self.mri_after.image = image
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
    func getImage(from imageDataString: String?) -> UIImage? {
        guard let imageDataString = imageDataString, let imageData = Data(base64Encoded: imageDataString) else {
            return nil
        }
        return UIImage(data: imageData)
    }

    func setButtonImage(_ button: UIButton, withImageData imageDataString: String) {
        guard let imageData = Data(base64Encoded: imageDataString) else {
            return
        }
        // Resize the image if needed
        if let resizedImage = resizeImage(UIImage(data: imageData)!, targetSize: CGSize(width: 150, height: 150)) {
            button.setImage(resizedImage, for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
        } else {
            print("Error resizing image.")
        }
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    func deletePatient() {
            guard let patientId = id else {
                return
            }

            let apiURL = APIList.deletepatientApi + ("id=\(patientId)" ) // Use patientId instead of id
            APIHandler().requestDeleteAPI(url: apiURL, method: "DELETE") { result in
                switch result {
                case .success(let data):
                        DispatchQueue.main.async {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
                            self.navigationController?.pushViewController(vc, animated: true)
                        }

                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Failed to delete the patient", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
