//
//  LogInViewController.swift
//  EmpulseHirs
//
//  Created by apple on 22/08/22.
//

import UIKit
class LogInViewController: UIViewController {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtServerUrl: UITextField!
    @IBOutlet weak var btnEYE: UIButton!
    var objLogInViewModel = LogInViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUserName.clearButtonMode = .always
        txtUserName.clearButtonMode = .whileEditing
        txtServerUrl.clearButtonMode = .always
        txtServerUrl.clearButtonMode = .whileEditing
    }
    @IBAction func actionLogIn(_ sender: UIButton) {
        baseURLStr = txtServerUrl.text!
        UserDefaults.standard.set(baseURLStr, forKey: "baseUrl")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        let objRequest = LoginRequestModel(email: txtUserName.text, password: txtPassword.text)
        objLogInViewModel.loginApi(loginRequest: objRequest, vw: self.view) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func actionEye(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            txtPassword.isSecureTextEntry = false
        }else{
            txtPassword.isSecureTextEntry = true
        }
    }
}
