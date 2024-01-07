//
//  Additional_info.swift
//  MOCA
//
//  Created by Mahesh on 10/10/23.
//

import UIKit

class Additional_info: UIViewController {

    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func next(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Patient_details") as! Patient_details
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
