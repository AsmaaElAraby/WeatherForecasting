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
        if let weatherState = todayWeatherData.getWeatherState().first {

            weatherStateSummary = weatherState.getElementDescription()
        }

        let objectsToShare = ["The current weather: \(weatherStateSummary), With degree \(MesurementsConversionManager.kelvinToCelsius(kelvinTemp: self.todayWeatherData.getTempretureDetails().getTemperature()))"]
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
        
        self.currentLocationLabel.text = "\(todayWeatherData.getName()), \(CountryCodeMapper.countryNameBy(code: todayWeatherData.getSunDetails().getCountry()))"
        
        if let weatherState = todayWeatherData.getWeatherState().first {
            
            self.weatherStateImageView.image = UIImage(named: WeatherStateMapper.getWeatherStateImageTitle(state: weatherState.getElementMain()))
            
            self.weatherSummaryLabel.text = "\(MesurementsConversionManager.kelvinToCelsius(kelvinTemp: self.todayWeatherData.getTempretureDetails().getTemperature()))°C | \(weatherState.getElementMain())"
        }
        
        self.posibilityOfRainLabel.text = "\(self.todayWeatherData.getClouds().getAll())%"
        self.humidityLabel.text = "\(self.todayWeatherData.getTempretureDetails().getHumidity()) mm"
        self.windSpeedLabel.text = "\(self.todayWeatherData.getWind().getSpeed()) km/h"
        self.pressureLabel.text = "\(self.todayWeatherData.getTempretureDetails().getPressure()) hPa"
        self.countryCodeLabel.text = MesurementsConversionManager.windDirectionFromDegrees(degree: self.todayWeatherData.getWind().getDegree() )
    }
    
}
