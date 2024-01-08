//
//  AddPatient.swift
//  MOCA
//
//  Created by AMAR on 25/10/23.
//

import UIKit

class AddPateint: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var AgeTF: UITextField!
    @IBOutlet weak var GenderTF: UITextField!
    @IBOutlet weak var Phone_numTF: UITextField!
    @IBOutlet weak var Alt_numTF: UITextField!
    @IBOutlet weak var DiagnosisTF: UITextField!
    @IBOutlet weak var DrugTF: UITextField!
    @IBOutlet weak var HippocampalTF: UITextField!
    @IBOutlet weak var AddPatientButton: UIButton!
    
    var selectedImages: [UIImage] = []
    var body = Data()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                self.view.addGestureRecognizer(tapGesture)
       
    }
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @IBAction func selectImage1Tapped(_ sender: Any) {
        presentImagePicker()
    }
    
    @IBAction func selectImage2Tapped(_ sender: Any) {
        presentImagePicker()
    }
    
//    @IBAction func selectImage3Tapped(_ sender: Any) {
//        presentImagePicker()
//    }
    
    func presentImagePicker() {
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
    
    // UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImages.append(pickedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backbtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func AddPatientbtn(_ sender: Any) {
        GetAPI()
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//extension AddPateint {
//        func GetAPI() {
//        let apiURL = APIList.AddPatientApi
//        print(apiURL)
//        // Generate a unique boundary string
//        let boundary = UUID().uuidString
//        var request = URLRequest(url: URL(string: apiURL)!)
//        request.httpMethod = "POST"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        // Append form data
//        let formData: [String: String] = [
//            "name": "\(NameTF.text ?? "Error")",
//            "age": "\(AgeTF.text ?? "Error")",
//            "gender": "\(GenderTF.text ?? "Error")",
//            "ph_num": "\(Phone_numTF.text ?? "Error")",
//            "alt_ph_num": "\(Alt_numTF.text ?? "Error")",
//            "Diagnosis": "\(DiagnosisTF.text ?? "Error")",
//            "Drug": "\(DrugTF.text ?? "Error")",
//            "hippocampal": "\(HippocampalTF.text ?? "Error")"
//        ]
//        for (key, value) in formData {
//            body.append(contentsOf: "--\(boundary)\r\n".utf8)
//            body.append(contentsOf: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8)
//            body.append(contentsOf: "\(value)\r\n".utf8)
//
//        }
//        // Append image data
//        for (index, image) in selectedImages.enumerated() {
//            let fieldName: String
//            switch index {
//            case 0:
//                fieldName = "patient_img"
////            case 1:
////                fieldName = "mri_before"
//            default:
//                fieldName = "mri_before"
//            }
//
//            let imageData = image.jpegData(compressionQuality: 0.8)!
//            body.append(contentsOf: "--\(boundary)\r\n".utf8)
//            body.append(contentsOf: "Content-Disposition: form-data; name=\"\(fieldName)[]\"; filename=\"\(UUID().uuidString).jpg\"\r\n".utf8)
//            body.append(contentsOf: "Content-Type: image/jpeg\r\n\r\n".utf8)
//            body.append(contentsOf: imageData)
//            body.append(contentsOf: "\r\n".utf8)
//        }
//        // Close the request body
//        body.append(contentsOf: "--\(boundary)\r\n".utf8)
//
//        request.httpBody = body
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // Handle the response
//            if let data = data {
//                // Parse the response data if needed
//                print("Response Data:", String(data: data, encoding: .utf8) ?? "")
//
//                // You can perform further processing here
//            }
//        }
//        task.resume()
//    }
//}







extension AddPateint {
    func GetAPI() {
        let apiURL = APIList.AddPatientApi     //"http://192.168.207.246//MOCA_AME/add_patient_final.php" //APIList.AddPatientApi
        print(apiURL)

        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

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

//        for (index, image) in selectedImages.enumerated() {
//            let fieldName: String
//            switch index {
//            case 0:
//                fieldName = "patient_img"
//            default:
//                fieldName = "mri_before"
//            }
//
//            let imageData = image.jpegData(compressionQuality: 0.8)!
//            body.append(contentsOf: "--\(boundary)\r\n".utf8)
//            body.append(contentsOf: "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(UUID().uuidString).jpg\"\r\n".utf8)
//            body.append(contentsOf: "Content-Type: image/jpeg\r\n\r\n".utf8)
//            body.append(contentsOf: imageData)
//            body.append(contentsOf: "\r\n".utf8)
        
        let fieldNames = ["patient_img", "mri_before"]

        for (index, image) in selectedImages.enumerated() {
            let fieldName = fieldNames[index]
            
            let imageData = image.jpegData(compressionQuality: 0.8)!
            body.append(contentsOf: "--\(boundary)\r\n".utf8)
            body.append(contentsOf: "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(UUID().uuidString).jpg\"\r\n".utf8)
            body.append(contentsOf: "Content-Type: image/jpeg\r\n\r\n".utf8)
            body.append(contentsOf: imageData)
            body.append(contentsOf: "\r\n".utf8)
        

        }

        body.append(contentsOf: "--\(boundary)--\r\n".utf8) // Close the request body

        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                // Handle the error, e.g., show an alert to the user
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")

                if let data = data {
                    print("Response Data:", String(data: data, encoding: .utf8) ?? "")
                    // You can perform further processing here
                }
            }
        }

        task.resume()
    }
}
