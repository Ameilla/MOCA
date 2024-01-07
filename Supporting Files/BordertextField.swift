//
//  BordertextField.swift
//  hrApplication
//
//  Created by SAIL on 21/09/23.
//

import Foundation
import UIKit

class BorderedTextField : UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.layer.cornerRadius = 9.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 52/255.0, green: 136/255.0, blue: 254/255.0, alpha: 1.0).cgColor
        self.layer.masksToBounds = true
    }
}
	
