//
//  UserModel.swift
//  BailPay
//
//  Created by apple on 17/03/1401 AP.
//

import UIKit
var objUserModelResponse = UserModelResponse()
class UserModelResponse: NSObject {
    var name = String()
    var userID = String()
    
    func handelData(dict: NSDictionary){
        name = dict["name"] as? String ?? ""
        userID = dict["emp_no"] as? String ?? ""
    }
}
