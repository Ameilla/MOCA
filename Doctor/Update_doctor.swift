//
//  Update_doctor.swift
//  MOCA
//
//  Created by AMAR on 26/10/23.
//

struct DoctorImage {
    var doctorImage: UIImage?
}
import UIKit

class Update_doctor: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profile_img: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var designationTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var id:String?
    var doctor_profile: DoctorProfileModel?
    var selectedButtonIndex: Int = 0
    var name,email,password,designation: String?
    var selectedImages: [DoctorImage] = []
    var body = Data()
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        PostAPI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    @IBAction func back(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: Doctor_Profile.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        PostAPI()
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func save(_ sender: Any) {
        GettAPI()
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Doctor_Profile") as! Doctor_Profile
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func image1(_ sender: Any) {
        presentImagePicker(forIndex: 0)
    }
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
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            updateSelectedImages(with: pickedImage)
        }

        picker.dismiss(animated: true, completion: nil)
    }

    func updateSelectedImages(with image: UIImage) {
        var imageData = DoctorImage()

        switch selectedButtonIndex {
        case 0:
            imageData.doctorImage = image
        default:
            break
        }

        // Ensure the selectedImages array has enough elements
        while selectedImages.count <= selectedButtonIndex {
            selectedImages.append(DoctorImage())
        }

        // Update the selected image data in the array
        selectedImages[selectedButtonIndex] = imageData
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
                    self.nameTF.text = self.doctor_profile?.name
                    self.emailTF.text = self.doctor_profile?.email
                    self.passwordTF.text = self.doctor_profile?.password
                    self.designationTF.text = self.doctor_profile?.designation
                    self.setButtonImage(self.profile_img, withImageData: (self.doctor_profile?.image)!)
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
//        let apiURL = APIList.DoctorProfileApi
//        print(apiURL)
//        APIHandler().getAPIValues(type: DoctorProfileModel.self, apiUrl: apiURL, method: "GET") { result in
//            switch result {
//            case .success(let data):
//                self.doctor_profile = data
//                DispatchQueue.main.async { [self] in
//                        self.nameTF.text = self.doctor_profile?.name
//                        self.emailTF.text = self.doctor_profile?.email
//                        self.passwordTF.text = self.doctor_profile?.password
//                        self.designationTF.text = self.doctor_profile?.designation
//                    self.setButtonImage(self.profile_img, withImageData: (self.doctor_profile?.image)!)
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
}
extension Update_doctor {
    func GettAPI() {
        let apiURL = APIList.DoctorProfileUpdateApi
        print(apiURL)
        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()

        let formData: [String: String] = [
            "name": "\(nameTF.text ?? "name")",
            "email": "\(emailTF.text ?? "email")",
            "password": "\(passwordTF.text ?? "password")",
            "designation": "\(designationTF.text ?? "designation")"
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
                    fieldName = "doctor_img"
                default:
                    continue
                }
                print("Image Data Size for \(fieldName):", imageData.count)

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

    func getImage(from imageData: DoctorImage) -> UIImage? {
        if let doctorImage = imageData.doctorImage {
            return doctorImage
        } else {
            return nil
        }
    }
}

