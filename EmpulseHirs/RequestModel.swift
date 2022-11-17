//
//  RequestModel.swift
//  BailPay
//
//  Created by apple on 17/03/1401 AP.
//

import Foundation
struct LoginRequestModel{
    var email:String?
    var password: String?
}
struct AddCustomerRequestModel{
    var name,email,password,phoneNumber,dob,cardNumber,expYear,expMonth,cvv: String?
}
struct ChangePasswordRequestModel{
    var confirmPassword,password: String?
}
