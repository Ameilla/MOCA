//
//  ResultCell.swift
//  MOCA
//
//  Created by AMAR on 18/11/23.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var task1: UILabel!
    @IBOutlet weak var task2: UILabel!
    @IBOutlet weak var task3: UILabel!
    @IBOutlet weak var task4: UILabel!
    @IBOutlet weak var task5: UILabel!
    @IBOutlet weak var task6: UILabel!
    @IBOutlet weak var task7: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var interpretation: UILabel!
    @IBOutlet weak var result: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        image1.layer.borderWidth = 1.0
        image2.layer.borderWidth = 1.0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
