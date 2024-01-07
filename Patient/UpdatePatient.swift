import UIKit

struct PatientImageData {
    var patientImage: UIImage?
    var mriBeforeImage: UIImage?
    var mriAfterImage: UIImage?
}

class UpdatePatient: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    @IBOutlet weak var profile_pic: UIButton!
    @IBOutlet weak var mri_before: UIImageView!
    @IBOutlet weak var mri_after: UIImageView!
    @IBOutlet weak var hippoTF: UITextField!
    @IBOutlet weak var drugTF: UITextField!
    @IBOutlet weak var diagnosisTF: UITextField!
    @IBOutlet weak var alter_ph_noTF: UITextField!
    @IBOutlet weak var phone_noTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var AddDetailsButton: UIButton!
    @IBOutlet weak var profile_Img: UIImageView!
    
    var id: String?
    var name, age, gender, ph_no, alter_ph_no, diagnosis, drug, hippo: String?
    var body = Data()
    let imagePicker = UIImagePickerController()
    
    var selectedButtonIndex: Int = 0
    var viewPatient: ViewPateintDetailsModel?

    var selectedImages: [PatientImageData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let cornerRadius1 = AddDetailsButton.frame.width * 0.05;        AddDetailsButton.layer.cornerRadius = cornerRadius1
        AddDetailsButton.layer.borderWidth = 1.0
        AddDetailsButton.layer.borderColor = UIColor.black.cgColor
        
        GetAPI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        profile_Img.addAction(for: .tap) {
            self.presentImagePicker(forIndex: 0)
        }
        mri_before.addAction(for: .tap) {
            self.presentImagePicker(forIndex: 1)
        }
        mri_after.addAction(for: .tap) {
            self.presentImagePicker(forIndex: 2)
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        GetAPI()
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

//    @IBAction func selectimage1(_ sender: Any) {
//        presentImagePicker(forIndex: 0)
//    }

//    @IBAction func selectimage2(_ sender: Any) {
//        presentImagePicker(forIndex: 1)
//    }
//
//    @IBAction func selectimage3(_ sender: Any) {
//        presentImagePicker(forIndex: 2)
//    }

    func presentImagePicker(forIndex index: Int) {
        selectedButtonIndex = index
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }

    func openGallery() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            updateSelectedImages(with: pickedImage)
        }

        picker.dismiss(animated: true, completion: nil)
    }

    func updateSelectedImages(with image: UIImage) {
        var imageData = PatientImageData()

        switch selectedButtonIndex {
        case 0:
            imageData.patientImage = image
            profile_Img.image = image //UIImage(named: "\(image)")
        case 1:
            imageData.mriBeforeImage = image
            mri_before.image = image
//            mri_before.setImage(image, for: .normal)

        case 2:
            imageData.mriAfterImage = image
            mri_after.image = image
//            mri_after.setImage(image, for: .normal)
        default:
            break
        }

        // Ensure the selectedImages array has enough elements
        while selectedImages.count <= selectedButtonIndex {
            selectedImages.append(PatientImageData())
        }

        // Update the selected image data in the array
        selectedImages[selectedButtonIndex] = imageData
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func UpdatePatientbtn(_ sender: Any) {
        GettAPI()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewPatientDetails") as! ViewPatientDetails
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func GetAPI() {
        let apiURL = APIList.ViewPatientApi
        print(apiURL)

        // Prepare POST parameters if needed
        let parameters: [String: String] = [
            "num" : id ?? "262"
            
            // "key1": value1,
            // "key2": value2,
        ]
        APIHandler().postAPIValues(type: ViewPateintDetailsModel.self, apiUrl: apiURL, method: "POST", formData: parameters) { result in
            switch result {
            case .success(let data):
                self.viewPatient = data
                print(data)
                DispatchQueue.main.async { [self] in
                    if let patientData = self.viewPatient?.data?.first {
                        self.nameTF.text=patientData.name
                        self.ageTF.text = patientData.age
                        self.genderTF.text = patientData.gender
                        self.phone_noTF.text = patientData.phoneNumber
                        self.alter_ph_noTF.text = patientData.alternateMobileNum
                        self.drugTF.text = patientData.drug
                        self.diagnosisTF.text = patientData.diagnosis
                        self.hippoTF.text = patientData.hippocampal
                        self.profile_Img.image = getImage(from: patientData.patientImg)
                        self.mri_before.image = getImage(from: patientData.mriBefore)
                        self.mri_after.image = getImage(from: patientData.mriAfter)
//                        self.setButtonImage(self.mri_before, withImageData: patientData.mriBefore)
//                        self.setButtonImage(self.mri_after, withImageData: patientData.mriAfter)
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
        guard !imageDataString.isEmpty, let imageData = Data(base64Encoded: imageDataString) else {
            // If imageDataString is empty or cannot be decoded, no action needed
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
}

extension UpdatePatient {
    func GettAPI() {
        let apiURL = APIList.updatePatientApi + (id ?? "262")
        print(apiURL)
        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()

        let formData: [String: String] = [
            "name": "\(nameTF.text ?? "name")",
            "age": "\(ageTF.text ?? "age")",
            "gender": "\(genderTF.text ?? "gender")",
            "ph_num": "\(phone_noTF.text ?? "ph_no")",
            "alt_ph_num": "\(alter_ph_noTF.text ?? "alter_ph_no")",
            "Diagnosis": "\(diagnosisTF.text ?? "diagnosis")",
            "Drug": "\(drugTF.text ?? "drug")",
            "hippocampal": "\(hippoTF.text ?? "hippo")"
        ]

        for (key, value) in formData {
            body.append(contentsOf: "--\(boundary)\r\n".utf8)
            body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8)
            body.append(contentsOf: "\(value)\r\n".utf8)
        }

        // Append image data for the selected button index
        for (index, imageData) in selectedImages.enumerated() {
            if let image = getImage(from: imageData), let imageData = image.jpegData(compressionQuality: 0.8) {
                let fieldName: String

                switch index {
                case 0:
                    fieldName = "patient_img"
                case 1:
                    fieldName = "mri_before"
                case 2:
                    fieldName = "mri_after"
                default:
                    continue
                }

                body.append(contentsOf: "--\(boundary)\r\n".utf8)
                body.append(contentsOf: "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(UUID().uuidString).jpg\"\r\n".utf8)
                body.append(contentsOf: "Content-Type: image/jpeg\r\n\r\n".utf8)
                body.append(contentsOf: imageData)
                body.append(contentsOf: "\r\n".utf8)
            }
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

    func getImage(from imageData: PatientImageData) -> UIImage? {
        if let patientImage = imageData.patientImage {
            return patientImage
        } else if let mriBeforeImage = imageData.mriBeforeImage {
            return mriBeforeImage
        } else if let mriAfterImage = imageData.mriAfterImage {
            return mriAfterImage
        } else {
            return nil
        }
    }
}
