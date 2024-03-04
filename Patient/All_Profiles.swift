//
//  All_Profiles.swift
//  MOCA
//
//  Created by AMAR on 07/12/23.
//
//

import UIKit

class All_Profiles: UIViewController{
    var id: String?
    var sideMenuViewController: SideMenuViewController?
    @IBOutlet weak var searchBar: UISearchBar!
    var isSideMenuOpen = true
    @IBOutlet weak var tbs: UITableView! {
        didSet {
            tbs.delegate = self
            tbs.dataSource = self
        }
    }
    var dashboard: DashboardModel!
    var searching = false
    var filtered: [DashData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchBar.delegate = self
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//                self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }

    @IBAction func back(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        for controller in self.navigationController!.viewControllers as Array {
        if controller.isKind(of: Dashboard.self) {
            self.navigationController!.popToViewController(controller, animated: true)
            break
        }
    }
    }
    override func viewWillAppear(_ animated: Bool) {
        getDashAPI()
    }
//    func getDashAPI() {
//        let apiURL = APIList.dashURL
//        print(apiURL)
//        APIHandler().getAPIValues(type: DashboardModel.self, apiUrl: apiURL, method: "GET") { result in
//            switch result {
//            case .success(let data):
//                self.dashboard = data
//                print(self.dashboard.data ?? "")
//                DispatchQueue.main.async {
////                    self.name.text = self.dashboard.data?.name
//                    self.tbs.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func getDashAPI() {
        
        let apiURL = APIList.dashURL
        print(apiURL)

        // Prepare POST parameters if needed
        let parameters: [String: String] = [:
            // Add your JSON parameters here if required
            // "key1": value1,
            // "key2": value2,
        ]

        APIHandler().postAPIValues(type: DashboardModel.self, apiUrl: apiURL, method: "POST", formData: parameters) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                self.dashboard = data
//                print(self.dashboard?.data ?? "")
//                    print("Dashboard Data: \(self.dashboard.data ?? [])")
                    self.tbs.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                // Stop loading animation
                               

                                // Enable user interaction
                                self.view.isUserInteractionEnabled = true

                            }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension All_Profiles:UITableViewDelegate,UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searching ? filtered.count : dashboard?.data?.count ?? 5
        }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Patient_info") as! Patient_info
        let data = searching ? filtered[indexPath.row] : dashboard?.data?[indexPath.row]
        vc.id = data?.id
        self.navigationController?.pushViewController(vc, animated: true)
        print("Cell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "ceil", for: indexPath) as! ceil
            let data = searching ? filtered[indexPath.row] : dashboard?.data?[indexPath.row]
            cell.lbl.text = data?.name
            cell.age.text = data?.age
            id = data?.id
        if let imageDataString = data?.patientImg,
           let imageData = Data(base64Encoded: imageDataString),
           let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                cell.patientImg?.image = image
                cell.patientImg?.contentMode = .scaleAspectFit
                   cell.patientImg?.clipsToBounds = true
            }
        } else {
            print("Error decoding image data")
        }
            return cell
        }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension All_Profiles: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searching = false
            filtered.removeAll()
        } else {
            searching = true
            filtered = dashboard?.data?.filter {
                $0.name?.range(of: searchText, options: .caseInsensitive) != nil
            } ?? []
        }
        tbs.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searching = false
        filtered.removeAll()
        tbs.reloadData()
    }
}

