//
//  TodayViewController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class TodayViewController: BaseViewController {
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var weatherStateImageView: UIImageView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    
    @IBOutlet weak var posibilityOfRainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    fileprivate var todayWeatherData: TodayWeatherForLocationResponse!
    private var doneLoadingData = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if doneLoadingData == false {
            doneLoadingData = true
            self.loadWeatherForecastDataForToday()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if todayWeatherData == nil {
            doneLoadingData = false
        }
    }
    
    
    @IBAction func shareButtonPressed() {
        
        var weatherStateSummary = ""
        if let weatherState = todayWeatherData.weather.first {
            
            weatherStateSummary = weatherState.description
        }
        
        let objectsToShare = ["The current weather: \(weatherStateSummary), With degree \(MesurementsConversionManager.kelvinToCelsius(kelvinTemp: self.todayWeatherData.tempretureDetails.temperature))"]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    /// Load the screen data
    private func loadWeatherForecastDataForToday() {
        
        let controller = TodayWeatherController(viewController: self)
        controller.setDelegate(delegate: self)
        controller.loadTodayDataForCurrentLocation()
    }
    
    
    /// update the screen ui text with the received data from the server
    fileprivate func updateScreenData() {
        
        self.currentLocationLabel.text = "\(todayWeatherData.name), \(CountryCodeMapper.countryNameBy(code: todayWeatherData.sunDetails.country))"
        
        if let weatherState = todayWeatherData.weather.first {
            
            self.weatherStateImageView.image = UIImage(named: WeatherStateMapper.getWeatherStateImageTitle(state: weatherState.main))
            
            self.weatherSummaryLabel.text = "\(MesurementsConversionManager.kelvinToCelsius(kelvinTemp: self.todayWeatherData.tempretureDetails.temperature))°C | \(weatherState.main)"
        }
        
        self.posibilityOfRainLabel.text = "\(self.todayWeatherData.clouds.all)%"
        self.humidityLabel.text = "\(self.todayWeatherData.tempretureDetails.humidity) mm"
        self.windSpeedLabel.text = "\(self.todayWeatherData.wind.speed) km/h"
        self.pressureLabel.text = "\(self.todayWeatherData.tempretureDetails.pressure) hPa"
        self.countryCodeLabel.text = MesurementsConversionManager.windDirectionFromDegrees(degree: self.todayWeatherData.wind.degree)
    }
    
}


extension TodayViewController: TodayWeatherDelegate {
    
    /// MARK: TodayWeatherDelegate Handling
    
    func didLoadData<T>(data: T) where T : Decodable, T : Encodable {
        
        guard let data = data as? TodayWeatherForLocationResponse, data.id > 0 else {
            
            self.noDataFoundLabel?.isHidden = false
            self.mainScrollView.isHidden = true
            return
        }
        
        self.mainScrollView.isHidden = false
        self.noDataFoundLabel?.isHidden = true
        
        self.todayWeatherData = data
        currentCityName = data.name
        
        DispatchQueue.main.async {
            
            self.updateScreenData()
        }
    }
    
    func didFail(message: String) {
        
        if message.count > 0 {
            self.noDataFoundLabel?.text = message
        }
        self.noDataFoundLabel?.isHidden = false
        self.mainScrollView.isHidden = true
    }
    
}
