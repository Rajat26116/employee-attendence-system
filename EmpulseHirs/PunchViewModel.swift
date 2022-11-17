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
class PunchViewModel : NSObject {
   
    func punchIn(vw:UIView,_ completion: @escaping(()->Void))
    {
        let request = AuthenticationServices.punch.task
            request.response { (response) in
                Proxy.shared.stopActivityIndicator()
                if response.data != nil && response.error == nil{
                    if let data = response.data {
                        let str = String(decoding: data, as: UTF8.self)
                        if str == "Success"{
                            debugPrint(str)
                            completion()
                            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                            let window = windowScene?.windows.first
                            window?.rootViewController?.view.makeToast("Punch In successfully", position:.center)
                        }
                    }
                }else{
                    debugPrint("Data Not Fond")
                }
            }
    }
    
    
    func punchOut(vw:UIView,_ completion: @escaping(()->Void))
    {
        let request = AuthenticationServices.punch.task
            request.response { (response) in
                Proxy.shared.stopActivityIndicator()
                if response.data != nil && response.error == nil{
                    if let data = response.data{
                        let str = String(decoding: data, as: UTF8.self)
                        if str == "Success"{
                            debugPrint(str)
                            completion()
                            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                            let window = windowScene?.windows.first
                            window?.rootViewController?.view.makeToast("Punch Out successfully", position:.center)
                        }
                    }
                }else{
                    debugPrint("Data Not Fond")
                }
            }
    }
}


