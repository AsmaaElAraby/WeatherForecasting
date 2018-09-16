//
//  BaseResponse.swift
//  Weather Forecasting
//
//  Created by Asma on 9/9/18.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol BaseResponse {

    /// create instance from TodayWeatherForLocationResponse with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON])
}
