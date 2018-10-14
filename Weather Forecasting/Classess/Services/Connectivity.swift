//
//  NetworkManager.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
