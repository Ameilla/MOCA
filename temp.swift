//
//  temp.swift
//  MOCA
//
//  Created by Mahesh on 08/10/23.
//

import UIKit

class temp: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell=sampleview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? samp	 {
            
            return cell
        return UITableViewCell()
    }
    

    @IBOutlet weak var sampleview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.samp

    }

}
