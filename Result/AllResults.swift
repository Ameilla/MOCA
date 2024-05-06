import UIKit

class AllResults: UIViewController {

    var ViewResult: ViewResultModel!
    var id: String?

    @IBOutlet weak var ResultsTableView: UITableView! {
        didSet {
            ResultsTableView.delegate = self
            ResultsTableView.dataSource = self
            ResultsTableView.rowHeight = UITableView.automaticDimension
            ResultsTableView.estimatedRowHeight = 150
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backBtn(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: Patient_info.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    @IBAction func graph(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Graph") as! Graph
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        getDashAPI()
    }

    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(origin: .zero, size: newSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        defer { UIGraphicsEndImageContext() }
        image.draw(in: rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func getDashAPI() {
        let apiURL = APIList.ViewResultApi + (id ?? "")
        print(apiURL)
        APIHandler().getAPIValues(type: ViewResultModel.self, apiUrl: apiURL, method: "GET") { result in
            switch result {
            case .success(let data):
                self.ViewResult = data
                DispatchQueue.main.async {
                    self.ResultsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AllResults: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewResult?.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        if let viewresult = self.ViewResult?.data[indexPath.row] {
            cell.task1.text = viewresult.task1
            cell.task2.text = viewresult.task2
            cell.task3.text = viewresult.task3
            cell.task4.text = viewresult.task4
            cell.task5.text = viewresult.task5
            cell.task6.text = viewresult.task6
            cell.task7.text = viewresult.task7
            cell.result.text = viewresult.result
            cell.interpretation.text = viewresult.interpretation
            cell.Date.text = "Date: \(viewresult.submissionDate)"


            if let imageDataString = viewresult.image1,
               let imageData = Data(base64Encoded: imageDataString),
               let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    if let resizedImage = self.resizeImage(image, targetSize: CGSize(width: 150, height: 150)) {
                        cell.image1?.image = resizedImage
                        cell.image1?.contentMode = .scaleAspectFill
                    } else {
                        print("Error resizing image.")
                    }
                }
            }
            if let imageDataString = viewresult.image2,
               let imageData = Data(base64Encoded: imageDataString),
               let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    if let resizedImage = self.resizeImage(image, targetSize: CGSize(width: 150, height: 150)) {
                        cell.image2?.image = resizedImage
                        cell.image2?.contentMode = .scaleAspectFill
                    } else {
                        print("Error resizing image.")
                    }
                }
            }
        }
        return cell
    }
}
