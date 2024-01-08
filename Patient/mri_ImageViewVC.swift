//
//  mri_ImageViewVC.swift
//  MOCA
//
//  Created by Amar on 08/01/24.
//

import UIKit

class mri_ImageViewVC: UIViewController {
    var img = UIImage()
    @IBOutlet weak var viewImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewImage.image = img
       
    }

    @IBAction func backbtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
}
