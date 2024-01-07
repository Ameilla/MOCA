//
//  baseViewController.swift
//  emaintenance
//
//  Created by SAIL on 05/10/23.
//

import UIKit
import SideMenu

class baseViewController: UIViewController {
    
    
    var menu: SideMenuNavigationController?
    
    let overlayView = UIView(frame: UIScreen.main.bounds)
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loads()
        
    }
    
    func loads(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = true
        
        //MARK: sideMenu call
        menu = SideMenuNavigationController(rootViewController: SideMenuController())
        menu?.leftSide = false
        
        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    static let DELAY_SHORT = 1.5
    static let DELAY_LONG = 3.0
    
    func showToast(_ text: String, delay: TimeInterval = DELAY_LONG) {
        let label = ToastLabel()
        label.backgroundColor = UIColor(white: 0, alpha: 1)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        label.alpha = 0
        label.text = text
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.numberOfLines = 0
        label.textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        let saveArea = view.safeAreaLayoutGuide
        label.centerXAnchor.constraint(equalTo: saveArea.centerXAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: saveArea.leadingAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: saveArea.trailingAnchor, constant: -15).isActive = true
        label.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor, constant: -30).isActive = true

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            label.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseOut, animations: {
                label.alpha = 0
            }, completion: {_ in
                label.removeFromSuperview()
            })
        })
    }
    //MARK: Active Indicator
    func startIndicator(){
        //MARK: UIView
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(overlayView)
        //MARK: Indicator
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.color = UIColor( red: CGFloat(59/255.0), green: CGFloat(58/255.0), blue: CGFloat(146/255.0), alpha: CGFloat(1.0) )
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    //MARK: removeIndicator
    func stopIndicator(){
        
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    
    
//    func navigateFunction(_: String ){
//        
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "\(String.self)") as! String
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }

    
}

class SideMenuController: UITableViewController {
    
    
    var superVisorFlow = ["Home","Work History","Raise Issue","Profile","Log out"]
    
    var managerFlow = ["Home","Work History","Add Supervisor","Add Worker","Rating","Profile","Log out"]
    
    var colour = UIColor(red: 63.0/255.0, green: 48.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    
    var superVisorImages = ["home 1","work-history 1","star","profileUser","logout 1"]
    var managerImages = ["home 1","work-history 1","addSymbol","addSymbol","star","profileUser","logout 1"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = colour
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerView")
        tableView.sectionHeaderHeight = 40
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as? TableViewHeaderView
        headerView?.titleLabel.text = "Menu"
        headerView?.titleLabel.textColor = UIColor.white
        headerView?.titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        return headerView
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserDefaultsManager.shared.getUserName() == "Manager"{
            return managerFlow.count
        }else{
            return superVisorFlow.count
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colour
        
        
        if UserDefaultsManager.shared.getUserName() == "Manager"{
            
            
               
                cell.textLabel?.text = managerFlow[indexPath.row]
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                cell.textLabel?.textColor = UIColor.white

                if cell.textLabel?.text == "Log out"{
                    cell.textLabel?.textColor = UIColor.red
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                }
                let imageName = managerImages[indexPath.row]
                            if let image = UIImage(named: imageName) {
                                cell.imageView?.image = image
                                cell.imageView?.backgroundColor = colour
                            }
            }else{
                cell.textLabel?.text = superVisorFlow[indexPath.row]
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                cell.textLabel?.textColor = UIColor.white
                if cell.textLabel?.text == "Log out"{
                    cell.textLabel?.textColor = UIColor.red
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                }
                let imageName = superVisorImages[indexPath.row]
                            if let image = UIImage(named: imageName) {
                                cell.imageView?.image = image
                                cell.imageView?.backgroundColor = colour
                            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if UserDefaultsManager.shared.getUserName() == "Manager"{
           
            if indexPath.row == 0 {
        
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "equipmentViewController") as! equipmentViewController
            self.navigationController?.pushViewController(vc, animated: true)
//            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
            }
            else if indexPath.row == 1
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "statusViewController") as! statusViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            else if indexPath.row == 2
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "addsupervisorViewController") as! addsupervisorViewController
                vc.titleName = "Add Supervisor"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 3
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "addsupervisorViewController") as! addsupervisorViewController
                vc.titleName = "Add Worker"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 4
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "rating1ViewController") as! rating1ViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 5
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "profilepageViewController") as! profilepageViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 6
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "startViewController") as! startViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            
            if indexPath.row == 0 {
            
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "equipmentViewController") as! equipmentViewController
                self.navigationController?.pushViewController(vc, animated: true)
    //            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
            }
            else if indexPath.row == 1
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "statusViewController") as! statusViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 2
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "issueViewController") as! issueViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 3
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "profile1ViewController") as! profile1ViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 4
            {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "startViewController") as! startViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }
}
class TableViewHeaderView: UITableViewHeaderFooterView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
       
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
@IBDesignable extension UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

@IBDesignable extension UIView {
        
    @IBInspectable var cornerRadiusView: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
class ToastLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)

        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}






class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults.standard

    private init() {}

    // MARK: - Define Keys for Your Data
    private let userNameKey = "UserName"
    private let userAgeKey = "UserAge"

    // MARK: - Save Data
    func saveUserName(_ name: String) {
        userDefaults.set(name, forKey: userNameKey)
    }

    func saveUserAge(_ age: Int) {
        userDefaults.set(age, forKey: userAgeKey)
    }

    // MARK: - Retrieve Data
    func getUserName() -> String? {
        return userDefaults.string(forKey: userNameKey)
    }

    func getUserAge() -> Int {
        return userDefaults.integer(forKey: userAgeKey)
    }

    // MARK: - Remove Data (if needed)
    func removeUserData() {
        userDefaults.removeObject(forKey: userNameKey)
        userDefaults.removeObject(forKey: userAgeKey)
    }
}



