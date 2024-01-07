//
//  table.swift
//  MOCA
//
//  Created by SAIL L1 on 05/10/23.
//

import UIKit

class table: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 5.0
        mainView.layer.borderColor = UIColor.blue.cgColor
        mainView.layer.borderWidth = 3.0
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
