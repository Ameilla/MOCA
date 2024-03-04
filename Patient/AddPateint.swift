import UIKit

protocol AddPatientDelegate: AnyObject {
    func didAddPatient()
}

class AddPateint: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    weak var delegate: AddPatientDelegate?
    
    @IBOutlet weak var t1: UIButton!
    @IBOutlet weak var t2: UIButton!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var AgeTF: UITextField!
    @IBOutlet weak var GenderTF: UITextField!
    @IBOutlet weak var Phone_numTF: UITextField!
    @IBOutlet weak var Alt_numTF: UITextField!
    @IBOutlet weak var DiagnosisTF: UITextField!
    @IBOutlet weak var DrugTF: UITextField!
    @IBOutlet weak var HippocampalTF: UITextField!
    @IBOutlet weak var AddPatientButton: UIButton!
    
    var selectedImages: [UIImage?] = [nil, nil]
    let imagePicker = UIImagePickerController()
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        updateButtonTitle(button: t1, forIndex: 0)
        updateButtonTitle(button: t2, forIndex: 1)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        AgeTF.delegate = self
        Phone_numTF.delegate = self
        Alt_numTF.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == AgeTF {
                // Allow only numeric input for AgeTF
                let allowedCharacterSet = CharacterSet.decimalDigits
                let enteredCharacterSet = CharacterSet(charactersIn: string)
                return allowedCharacterSet.isSuperset(of: enteredCharacterSet)
            } else if textField == Phone_numTF || textField == Alt_numTF {
                // Allow only numeric input for Phone_numTF and Alt_numTF and limit length to 10
                let numericCharacterSet = CharacterSet.decimalDigits
                let enteredCharacterSet = CharacterSet(charactersIn: string)
                let isNumeric = numericCharacterSet.isSuperset(of: enteredCharacterSet)
                
                let currentText = textField.text ?? ""
                let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
                let isValidLength = newText.count <= 10
                
                return isNumeric && isValidLength
            }
            return true
        }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func selectImage1Tapped(_ sender: Any) {
        presentImagePicker(forIndex: 0)
    }
    
    @IBAction func selectImage2Tapped(_ sender: Any) {
        presentImagePicker(forIndex: 1)
    }
    
    func presentImagePicker(forIndex index: Int) {
        selectedIndex = index
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

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage, let index = selectedIndex {
            selectedImages[index] = pickedImage
            updateButtonTitle(button: index == 0 ? t1 : t2, forIndex: index)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // Update button title function
    func updateButtonTitle(button: UIButton, forIndex index: Int) {
        if let _ = selectedImages[index] {
            button.setTitle("Image Uploaded", for: .normal)
        } else {
            button.setTitle("Select an Image", for: .normal)
        }
    }

    
    @IBAction func backbtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func AddPatientbtn(_ sender: Any) {
        GetAPI()
    }
}

extension AddPateint {
    func GetAPI() {
        let apiURL = APIList.AddPatientApi
        print(apiURL)

        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()
        
        let formData: [String: String] = [
            "name": "\(NameTF.text ?? "Error")",
            "age": "\(AgeTF.text ?? "Error")",
            "gender": "\(GenderTF.text ?? "Error")",
            "ph_num": "\(Phone_numTF.text ?? "Error")",
            "alt_ph_num": "\(Alt_numTF.text ?? "Error")",
            "Diagnosis": "\(DiagnosisTF.text ?? "Error")",
            "Drug": "\(DrugTF.text ?? "Error")",
            "hippocampal": "\(HippocampalTF.text ?? "Error")"
        ]

        for (key, value) in formData {
            body.append(contentsOf: "--\(boundary)\r\n".utf8)
            body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8)
            body.append(contentsOf: "\(value)\r\n".utf8)
        }
        
        let fieldNames = ["patient_img", "mri_before"]

        for (index, image) in selectedImages.enumerated() {
            if let image = image {
                let fieldName = fieldNames[index]
                
                let imageData = image.jpegData(compressionQuality: 0.8)!
                body.append(contentsOf: "--\(boundary)\r\n".utf8)
                body.append(contentsOf: "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(UUID().uuidString).jpg\"\r\n".utf8)
                body.append(contentsOf: "Content-Type: image/jpeg\r\n\r\n".utf8)
                body.append(contentsOf: imageData)
                body.append(contentsOf: "\r\n".utf8)
            }
        }
        
        body.append(contentsOf: "--\(boundary)--\r\n".utf8) // Close the request body

        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")

                if let data = data {
                    print("Response Data:", String(data: data, encoding: .utf8) ?? "")
                }
            }
            DispatchQueue.main.async {
                self.delegate?.didAddPatient() // Notify delegate
                self.navigationController?.popViewController(animated: true)
            }
        }
        task.resume()
    }
}
