//
//  SunDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct SunDetailsDataModel: Codable {
    
    let type:       Int?
    let id:         Int?
    let message:    Double?
    let country:    String?
    let sunrise:    Double
    let sunset:     Double
    
}
