//
//  WeatherSummaryTableViewCell.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class WeatherSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var weatherStateImageView: UIImageView!
    @IBOutlet weak var separatorImageView: UIImageView!
    
    private var cellData: WeatherForADayDataModel!
    
    
    /// set the cell data
    ///
    /// - Parameter cellData: WeatherForADayDataModel
    internal func setCellData(cellData: WeatherForADayDataModel) {
        self.cellData = cellData
        
        DispatchQueue.main.async { [weak self] in
            
            self?.weatherDegreeLabel.text = "\(TemperatureHandler.kelvinToCelsius(degree: self?.cellData.main.temperature ?? 0))°"
            self?.dayLabel.text = self?.cellData.hour
            
            if let weatherState = self?.cellData.weather.first {
                
                self?.weatherStateLabel.text = weatherState.main
                self?.weatherStateImageView.image = UIImage(named: WeatherHandler.imageNameFor(screenName: .forcast, weatherStateId: weatherState.id, isDay: self?.cellData.isDay ?? false))
                
            }
        }
    }
    
    func separatorVisable(_ flag: Bool) {
        
        separatorImageView.isHidden = !flag
    }
    
}
