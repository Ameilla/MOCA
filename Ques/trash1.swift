//
//  trash1.swift
//  MOCA
//
//  Created by SAIL L1 on 07/10/23.
//

import UIKit

class trash1: UIViewController {

    @IBOutlet weak var bor: UIView!
    @IBOutlet weak var nextbar: UIView!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var canvasview: CanvasView!
    var task1=0
    var img = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bor.layer.cornerRadius = 25
        bor.layer.masksToBounds=true
        nextbar.layer.cornerRadius = 17
        task1=task1+1
        print(task1)
       
    }
    
    @IBAction func que4(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ques_4") as! ques_4
        vc.task1=task1
        vc.img = img
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
