//
//  ceil.swift
//  MOCA
//
//  Created by SAIL on 12/10/23.
//

import UIKit

class ceil: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var patientImg : UIImageView!
    @IBOutlet weak var age: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        patientImg.contentMode = .scaleAspectFit
        patientImg.clipsToBounds = true
        patientImg.translatesAutoresizingMaskIntoConstraints = false
        
        box.layer.borderWidth = 1.0
        box.layer.borderColor = UIColor.black.cgColor
        box.layer.cornerRadius = 8.0
        box.backgroundColor = UIColor(red: 0xD9 / 255.0, green: 0xD9 / 255.0, blue: 0xD9 / 255.0, alpha: 1.0)
        
        
//        patientImg.contentMode = .scaleAspectFit
//                patientImg.clipsToBounds = true
//                patientImg.isUserInteractionEnabled = true 
                
                box.layer.borderWidth = 1.0
                box.layer.borderColor = UIColor.black.cgColor
                box.layer.cornerRadius = 8.0
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
