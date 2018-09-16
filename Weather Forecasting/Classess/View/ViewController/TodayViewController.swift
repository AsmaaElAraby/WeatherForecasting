//
//  TodayViewController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, TodayWeatherDelegate {
    
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
    
    private var todayWeatherData: TodayWeatherForLocationResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadWeatherForecastDataForToday()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    /// MARK: TodayWeatherDelegate Handling
    
    func didLoadTodayWeatherData(data: TodayWeatherForLocationResponse) {

        self.todayWeatherData = data

        DispatchQueue.main.async {
            
            self.updateScreenData()
        }
    }
    
    func didFail(message: String) {
        
        self.mainScrollView.isHidden = true
    }
    
    
    /// update the screen ui text with the received data from the server
    private func updateScreenData() {
        
        self.currentLocationLabel.text = "\(todayWeatherData.name), \(CountryCodeMapper.countryNameBy(code: todayWeatherData.sunDetails.country))"
        
        if let weatherState = todayWeatherData.weather.first {
            
            self.weatherStateImageView.image = UIImage(named: WeatherStateMapper.getWeatherStateImageTitle(state: weatherState.main ?? ""))
            
            self.weatherSummaryLabel.text = "\(MesurementsConversionManager.kelvinToCelsius(kelvinTemp: self.todayWeatherData.tempretureDetails.temperature))°C | \(weatherState.main ?? "")"
        }
        
        self.posibilityOfRainLabel.text = "\(self.todayWeatherData.clouds.all)%"
        self.humidityLabel.text = "\(self.todayWeatherData.tempretureDetails.humidity) mm"
        self.windSpeedLabel.text = "\(self.todayWeatherData.wind.speed) km/h"
        self.pressureLabel.text = "\(self.todayWeatherData.tempretureDetails.pressure) hPa"
        self.countryCodeLabel.text = MesurementsConversionManager.windDirectionFromDegrees(degree: self.todayWeatherData.wind.degree)
    }
    
}
