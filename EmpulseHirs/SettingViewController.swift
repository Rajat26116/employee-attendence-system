//
//  SettingViewController.swift
//  EmpulseHirs
//
//  Created by apple on 23/08/22.
//

import UIKit
import TextFieldEffects

class SettingViewController: UIViewController {

    @IBOutlet weak var labelEmployeeId: UILabel!
    @IBOutlet weak var txtServerUrl: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtServerUrl.clearButtonMode = .always
        txtServerUrl.clearButtonMode = .whileEditing
        labelEmployeeId.text = UserDefaults.standard.string(forKey: "userID")
        txtServerUrl.text =  UserDefaults.standard.string(forKey: "baseUrl")
    }
   
    @IBAction func actionCross(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func actionSave(_ sender: Any) {
        dismiss(animated: true)
    }
}
