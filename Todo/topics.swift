//
//  topics.swift
//  MOCA
//
//  Created by Mahesh on 10/10/23.
//

import UIKit

class topics: UIViewController {

    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var l6: UILabel!
    @IBOutlet weak var l7: UILabel!
    @IBOutlet weak var l8: UILabel!
    @IBOutlet weak var l9: UILabel!
    @IBOutlet weak var l10: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        l1.layer.borderWidth = 1.0
        l1.layer.borderColor = UIColor.black.cgColor
        l1.layer.cornerRadius = 8.0
        l2.layer.borderWidth = 1.0
        l2.layer.borderColor = UIColor.black.cgColor
        l2.layer.cornerRadius = 8.0
        l3.layer.borderWidth = 1.0
        l3.layer.borderColor = UIColor.black.cgColor
        l3.layer.cornerRadius = 8.0
        l4.layer.borderWidth = 1.0
        l4.layer.borderColor = UIColor.black.cgColor
        l4.layer.cornerRadius = 8.0
        l5.layer.borderWidth = 1.0
        l5.layer.borderColor = UIColor.black.cgColor
        l5.layer.cornerRadius = 8.0
        l6.layer.borderWidth = 1.0
        l6.layer.borderColor = UIColor.black.cgColor
        l6.layer.cornerRadius = 8.0
        l7.layer.borderWidth = 1.0
        l7.layer.borderColor = UIColor.black.cgColor
        l7.layer.cornerRadius = 8.0
        l8.layer.borderWidth = 1.0
        l8.layer.borderColor = UIColor.black.cgColor
        l8.layer.cornerRadius = 8.0
        l9.layer.borderWidth = 1.0
        l9.layer.borderColor = UIColor.black.cgColor
        l9.layer.cornerRadius = 8.0
        l10.layer.borderWidth = 1.0
        l10.layer.borderColor = UIColor.black.cgColor
        l10.layer.cornerRadius = 8.0
    }
    
    @IBAction func backbtn(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: Dashboard.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
   

}
