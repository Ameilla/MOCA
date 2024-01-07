//
//  Patient_info.swift
//  MOCA
//
//  Created by SAIL L1 on 06/10/23.
//

import UIKit

class Patient_details: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBAction func next(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Patient_info") as! Patient_info
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
