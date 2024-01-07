//
//  Add_patient_details.swift
//  MOCA
//
//  Created by SAIL L1 on 06/10/23.
//

import UIKit

class Add_patient_details: UIViewController {

    @IBOutlet weak var back_btn: UIButton!
    
    @IBOutlet weak var add_btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden=true;

        
    }
    
    
    @IBAction func back_btn(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func add_btn(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
