import UIKit

class menubar: UIViewController {

    @IBOutlet weak var menuButton: UIButton!

    // This will hold a reference to the side menu
    var sideMenuViewController: SideMenuViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Instantiate the SideMenuViewController from the storyboard
        guard let sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController else {
            return
        }

        // Set the width of the side menu
        let menuWidth: CGFloat = 280
        sideMenuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)

        // Add the side menu as a child view controller
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)

        // Save a reference to the side menu for later use
        self.sideMenuViewController = sideMenuViewController

        // Add a tap gesture recognizer to the main view controller
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @IBAction func menuButtonPressed(_ sender: UIButton) {
        showSideMenu()
    }

    private func showSideMenu() {
        guard let sideMenuViewController = self.sideMenuViewController else {
            return
        }

        // Animate to show the side menu
        UIView.animate(withDuration: 0.3) {
            sideMenuViewController.view.frame.origin.x = 0
        }
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        hideSideMenu()
    }

    private func hideSideMenu() {
        guard let sideMenuViewController = self.sideMenuViewController else {
            return
        }

        // Animate to hide the side menu
        UIView.animate(withDuration: 0.3) {
            sideMenuViewController.view.frame.origin.x = -sideMenuViewController.view.frame.width
        }
    }
}
