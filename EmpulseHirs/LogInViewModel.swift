//
//  SignInViewModel.swift
//  BailPay
//
//  Created by apple on 17/03/1401 AP.
//
import Foundation
import UIKit
import SCLAlertView
import Toast_Swift
import Alamofire
class LogInViewModel : NSObject {
    //MARK: Variables
    func loginApi(loginRequest: LoginRequestModel,vw:UIView,_ completion: @escaping(()->Void))
    {
        if vaild(vw:vw, loginRequest: loginRequest){
            let request = AuthenticationServices.login(loginRequestModel: loginRequest).task
            request.response { (response) in
                Proxy.shared.stopActivityIndicator()
                if response.data != nil && response.error == nil{
                    if let data = response.data{
                        let str = String(decoding: data, as: UTF8.self)
                        do {
                            if str == "Reject"{
                                vw.makeToast("Please enter valid credentials.")
                            }
                            else{
                                debugPrint(response.request)
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                                    debugPrint(json)
                                    objUserModelResponse.handelData(dict: json)
                                    UserDefaults.standard.set(objUserModelResponse.name, forKey: "name")
                                    UserDefaults.standard.set(objUserModelResponse.userID, forKey: "userID")
                                    UserDefaults.standard.synchronize()
                                    completion()
                                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                                    let window = windowScene?.windows.first
                                    window?.rootViewController?.view.makeToast("login successfull", position:.center)
                                }
                            }
                        } catch let error as NSError {
                            print("Failed in JSONSerialization: \(error.localizedDescription)")
                            vw.makeToast("Please enter valid credentials.")
                        }
                    }
                }else{
                    debugPrint("Data Not Fond")
                    vw.makeToast("Please enter valid server url")
                }
            }
        }
    }
    func vaild(vw:UIView,loginRequest: LoginRequestModel) -> Bool{
        if loginRequest.email!.isEmpty || loginRequest.password!.isEmpty{
            vw.makeToast("Email and password is required")
            return false
        }else if baseURLStr.isEmpty{
            vw.makeToast("You can not leave blank server Url")
            return false
        }
        return true
    }
}
