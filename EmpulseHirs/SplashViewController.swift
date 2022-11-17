//
//  SplashViewController.swift
//  EmpulseHirs
//
//  Created by apple on 23/08/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(0)
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
}
