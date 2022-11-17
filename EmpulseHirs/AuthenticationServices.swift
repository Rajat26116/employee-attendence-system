//
//  GetServices.swift
//  DowntownBookings
//
//  Created by Admin on 14/01/22.
//  Copyright © 2022 Reveralto Infotech. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
enum AuthenticationServices {
   
    case login(loginRequestModel:LoginRequestModel)
    case punch
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var baseURL: URL {
        return URL(string: UserDefaults.standard.string(forKey: "baseUrl")!.trimmingLeadingAndTrailingSpaces())!
    }
    var path: String {
        switch self {
        case .login:
            return "/iOSAPI/loginMe"
        case .punch:
            return "/iOSAPI/MobilePunch"
        }
    }
    var parameter : [String : Any]? {
        var parameters : [String : Any]? = nil
        let modelName = UIDevice.modelName
        switch self {
        case .login(loginRequestModel: let loginRequestModel):
            parameters = ["User_ID": loginRequestModel.email ?? "" ,
                          "Password": loginRequestModel.password ?? "",
                          "manufacturer":"apple",
                          "model":modelName,
                          "release":UIDevice.current.systemVersion,
                          "ip":getWiFiAddress() ?? "",
                          "System_Name":UIDevice.current.systemName
            ]
        case .punch:
            parameters = ["User_ID":UserDefaults.standard.string(forKey: "userID"),
                          "PunchType":PunchType,
                          "PunchTime":punchTime,
                          "Latitude":lat,
                          "Longitude":long
            ] as! [String : String]
        }
        return parameters
    }
    var method: HTTPMethod {
        switch self {
        case .login(loginRequestModel: let loginRequestModel):
            return .get
        case .punch:
            return .get
        }
    }
    var headers: [String : String]? {
        switch self {
        case .login(loginRequestModel: let loginRequestModel):
            var headers = ["Content-Type": "application/json"]
            return headers
        case .punch:
            var headers = ["Content-Type": "application/json"]
            return headers
        }
    }
    var task : DataRequest{
        if !InternetConnectivity.isConnectedToInternet{
           debugPrint("Does not connected to internet")
            SCLAlertView().showWait("Network Issue", subTitle: "No internet connection")
//            vw.makeToast("No internet connection")

        }
        switch self {
        case .login :
            debugPrint("path --> \(baseURL)\(path)")
            debugPrint("method --> \(method)")
            debugPrint("parameter --> \(String(describing: parameter))")
            debugPrint("encoding --> \(parameterEncoding)")
            debugPrint("header --> \(String(describing: headers))")
            Proxy.shared.startActivityIndicator()
            return Alamofire.request("\(baseURL)\(path)", method: method, parameters: parameter,encoding:parameterEncoding, headers: headers)
        case .punch:
            debugPrint("path --> \(baseURL)\(path)")
            debugPrint("method --> \(method)")
            debugPrint("parameter --> \(String(describing: parameter))")
            debugPrint("encoding --> \(parameterEncoding)")
            debugPrint("header --> \(String(describing: headers))")
            Proxy.shared.startActivityIndicator()
            return Alamofire.request("\(baseURL)\(path)", method: method, parameters: parameter,encoding:parameterEncoding, headers: headers)
        }
    }
}
func getWiFiAddress() -> String? {
    var address : String?

    // Get list of all interfaces on the local machine:
    var ifaddr : UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else { return nil }
    guard let firstAddr = ifaddr else { return nil }

    // For each interface ...
    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let interface = ifptr.pointee

        // Check for IPv4 or IPv6 interface:
        let addrFamily = interface.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

            // Check interface name:
            let name = String(cString: interface.ifa_name)
            if  name == "en0" {

                // Convert interface address to a human readable string:
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST)
                address = String(cString: hostname)
            }
        }
    }
    freeifaddrs(ifaddr)

    return address
}
extension String {
    func trimmingLeadingAndTrailingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return trimmingCharacters(in: characterSet)
    }
}
