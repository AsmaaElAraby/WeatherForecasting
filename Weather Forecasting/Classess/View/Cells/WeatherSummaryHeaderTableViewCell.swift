//
//  WeatherSummaryHeaderTableViewCell.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class WeatherSummaryHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    /// set the cell data
    ///
    /// - Parameter cellData: String
    internal func setCellData(cellData: String) {
        
        titleLabel.text = cellData.uppercased()
    }
    
}
