import UIKit

class Dashboard: UIViewController {
    var id: String?
    @IBOutlet weak var menuButton: UIButton!
    var sideMenuViewController: SideMenuViewController?
    @IBOutlet weak var AddPatient: UIButton!
    @IBOutlet weak var boc: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSideMenuOpen = false
    @IBOutlet weak var tbs: UITableView! {
        didSet {
            tbs.delegate = self
            tbs.dataSource = self
        }
    }
    var dashboard: DashboardModel?
    var searching = false
    var filtered: [DashData] = []
    var activityIndicator: UIActivityIndicatorView!
    var overlayView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDashAPI()
    }

    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        searchBar.delegate = self
        let cornerRadius1 = AddPatient.frame.width * 0.1
        AddPatient.layer.cornerRadius = cornerRadius1
        AddPatient.layer.borderWidth = 1.0
        AddPatient.layer.borderColor = UIColor.black.cgColor
        
        guard let sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController else {
            return
        }
        let menuWidth: CGFloat = 280
        sideMenuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)
        self.sideMenuViewController = sideMenuViewController
        
        menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideMenu(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        tbs.isUserInteractionEnabled = true
        activityIndicatorLoads()
    }

    private func activityIndicatorLoads() {
        // Implement activity indicator setup here if needed
    }

    @objc func menuButtonPressed() {
        isSideMenuOpen ? hideSideMenu() : showSideMenu()
    }

    private func showSideMenu() {
        guard let sideMenuViewController = self.sideMenuViewController else { return }
        UIView.animate(withDuration: 0.3) {
            sideMenuViewController.view.frame.origin.x = 0
        }
        isSideMenuOpen = true
    }

    @objc func handleTapOutsideMenu(_ sender: UITapGestureRecognizer) {
        searchBar.endEditing(true)
        let location = sender.location(in: sideMenuViewController?.view)
        
        if let sideMenuView = sideMenuViewController?.view, !sideMenuView.frame.contains(location) {
            hideSideMenu()
        }
    }

    private func hideSideMenu() {
        guard let sideMenuViewController = self.sideMenuViewController else { return }
        UIView.animate(withDuration: 0.3) {
            sideMenuViewController.view.frame.origin.x = -sideMenuViewController.view.frame.width
        }
        isSideMenuOpen = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDashAPI()
    }

    func getDashAPI() {
        let apiURL = APIList.dashURL
        print(apiURL)
        
        APIHandler().postAPIValues(type: DashboardModel.self, apiUrl: apiURL, method: "POST", formData: [:]) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.dashboard = data
                    self.tbs.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func SeeMore(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "All_Profiles") as! All_Profiles
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func next(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddPateint") as! AddPateint
        vc.delegate = self // Set delegate
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension Dashboard: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? filtered.count : dashboard?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Patient_info") as! Patient_info
        let data = searching ? filtered[indexPath.row] : dashboard?.data?[indexPath.row]
        vc.id = data?.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ceil", for: indexPath) as! ceil
        let data = searching ? filtered[indexPath.row] : dashboard?.data?[indexPath.row]
        cell.lbl.text = data?.name
        cell.age.text = data?.age
        cell.diagnosis.text = data?.diagnosis
        id = data?.id
        if let imageDataString = data?.patientImg,
            let imageData = Data(base64Encoded: imageDataString),
            let image = UIImage(data: imageData) {
            cell.patientImg?.image = image
            cell.patientImg?.contentMode = .scaleToFill
            cell.patientImg?.clipsToBounds = true
            cell.patientImg?.layer.cornerRadius = cell.patientImg.frame.height / 2
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension Dashboard: UISearchBarDelegate {
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

extension Dashboard: AddPatientDelegate {
    func didAddPatient() {
        getDashAPI() // Reload data when a new patient is added
    }
}
