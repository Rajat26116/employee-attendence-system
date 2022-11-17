//
//  NetworkCon.swift
//  DowntownBookings
//
//  Created by Admin on 23/02/22.
//  Copyright © 2022 Reveralto Infotech. All rights reserved.
//

import Foundation
import Alamofire

class InternetConnectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
