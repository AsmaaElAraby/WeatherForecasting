//
//  WeatherSummaryTableViewCell.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

enum WeatherStateImageTitles: String {
    
    case Sunny  = "clear"
    case Windy  = "wind"
    case Rain   = "rain"
    case Snow   = "snow"
    case Lightning  = "light"
    case Cloudy     = "clouds"
}

class WeatherSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var weatherStateImageView: UIImageView!
    
    private var cellData: WeatherForADayDataModel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    /// set the cell data
    ///
    /// - Parameter cellData: WeatherForADayDataModel
    internal func setCellData(cellData: WeatherForADayDataModel) {
        self.cellData = cellData
        
        DispatchQueue.main.async {

            self.weatherDegreeLabel.text = "\(MesurementsConversionManager.kelvinToCelsius(kelvinTemp: self.cellData.getTemperature().getAppropriateTempreture()))°"
            self.dayLabel.text = self.cellData.getDateDay()
            
            if let weatherState = self.cellData.getWeather().first {
            
                self.weatherStateLabel.text = weatherState.getElementMain()
                self.weatherStateImageView.image = UIImage(named: WeatherStateMapper.getWeatherStateImageTitle(state: weatherState.getElementMain()))
                
            }
        }
    }
    
}
