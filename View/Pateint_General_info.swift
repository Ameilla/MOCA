//
//  Pateint_General_info.swift
//  MOCA
//
//  Created by Mahesh on 10/10/23.
//

import UIKit

class Pateint_General_info: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func next(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Additional_info") as! Additional_info
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
