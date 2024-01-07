//
//  ques_2.swift
//  MOCA
//
//  Created by SAIL L1 on 09/10/23.
//

import UIKit

class ques_2: UIViewController {

    @IBOutlet weak var bor: UIView!
    
    @IBOutlet weak var nextbar: UIView!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var canvas: CanvasView!
    var task1=0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bor.layer.cornerRadius = 25
        bor.layer.masksToBounds=true
        nextbar.layer.cornerRadius = 17
        task1=task1+1
    }
    

  
  
    @IBAction func que3(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "trash1") as! trash1
        vc.task1=task1
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}
