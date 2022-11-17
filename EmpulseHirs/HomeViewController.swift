//
//  HomeViewController.swift
//  EmpulseHirs
//
//  Created by apple on 22/08/22.
//

import UIKit
class HomeViewController: UIViewController {
    @IBOutlet weak var labelUserName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelUserName.text = UserDefaults.standard.string(forKey: "name") ?? "Uttam Kumar Barai"
        // Do any additional setup after loading the view.
        
       debugPrint(UIDevice.current.identifierForVendor?.uuidString)
       debugPrint(UIDevice.current.systemVersion)
    }
    @IBAction func actionLogOut(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Exit", message: "Do you want to logout ?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.goToLogoutScreen()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    @IBAction func actionSetting(_ sender: UIButton) {
        if sender.tag == 0{
            let settingVc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            present(settingVc, animated: true)
        }else{
            dismiss(animated: true)
        }
    }
    @IBAction func actionPunch(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PunchInOutViewController") as! PunchInOutViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func goToLogoutScreen(){
        UserDefaults.standard.set(nil, forKey: "name")
        UserDefaults.standard.set(nil, forKey: "userID")
        UserDefaults.standard.set(nil, forKey: "baseUrl")
        UserDefaults.standard.synchronize()
        let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        vc.view.makeToast("Logout successfull")
        let nav = UINavigationController()
        nav.isNavigationBarHidden = true
        nav.viewControllers = [vc]
        window!.rootViewController = nav
        window!.makeKeyAndVisible()
    }
}
