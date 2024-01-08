//
//  SideMenuViewController.swift
//  MOCA
//
//  Created by AMAR on 03/12/23.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var bt: UIButton!
    var sideMenuViewController: SideMenuViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            view.addGestureRecognizer(tapGesture)
        }

        // Function to handle tap gesture
        @objc func handleTap() {
            // Perform the logic to pop the view controller
//            navigationController?.popViewController(animated: true)
//            guard let sideMenuViewController = self.sideMenuViewController else {
//                return
//            }

            // Animate to hide the side menu
//            UIView.animate(withDuration: 0.3) {
            sideMenuViewController?.view.frame.origin.x = -(sideMenuViewController?.view.frame.width ?? 0)
//            }
        }
    
    @IBAction func DoctorProfile(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Doctor_Profile") as! Doctor_Profile
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Dashboard(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Patients(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "All_Profiles") as! All_Profiles
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Topics(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "topics") as! topics
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func About(_ sender: Any) {
    }
    
    @IBAction func Logout(_ sender: Any) {
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
