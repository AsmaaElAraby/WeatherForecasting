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
    
    lazy var andicatingView: AndicatingView = {
        
        return AndicatingView()
    }()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if doneLoadingData == false {
            doneLoadingData = true
            loadWeatherForecastDataForToday()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
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
        
        let objectsToShare = ["\(NSLocalizedString("theCurrentWeather", comment: ""))\(weatherStateSummary)\(NSLocalizedString(", With degree ", comment: ""))\(TemperatureHandler.kelvinToCelsius(degree: todayWeatherData.tempretureDetails.temperature))"]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
    
    /// Load the screen data
    private func loadWeatherForecastDataForToday() {
        
        let controller = TodayWeatherController()
        controller.setDelegate(delegate: self)
        controller.loadTodayWeatherForCurrentLocation()
    }
    
    /// update the screen ui text with the received data from the server
    fileprivate func updateScreenData() {
        
        currentLocationLabel.text = "\(todayWeatherData.name.count > 0 ? todayWeatherData.name : currentCityName ?? ""), \(CountryHandler.countryNameFor(code: todayWeatherData.sunDetails.country ?? ""))"
        
        if let weatherState = todayWeatherData.weather.first {
            
            weatherStateImageView.image = UIImage(named: WeatherHandler.imageNameFor(screenName: .today, weatherStateId: weatherState.id, isDay: todayWeatherData.isDay))
            
            weatherSummaryLabel.text = "\(TemperatureHandler.kelvinToCelsius(degree: todayWeatherData.tempretureDetails.temperature))°C | \(weatherState.main)"
        }
        
        posibilityOfRainLabel.text = "\(todayWeatherData.clouds.all)%"
        humidityLabel.text = "\(self.todayWeatherData.tempretureDetails.humidity) mm"
        windSpeedLabel.text = "\(todayWeatherData.wind?.speed ?? 0.0) km/h"
        pressureLabel.text = "\(todayWeatherData.tempretureDetails.pressure) hPa"
        if let degree = todayWeatherData.wind?.degree {
            countryCodeLabel.text = WeatherHandler.windDirectionFor(degree: degree)
        } else {
            countryCodeLabel.text = "__"
        }
    }
    
}

extension TodayViewController: TodayWeatherDelegate {
    
    /// MARK: TodayWeatherDelegate Handling
    
    func willLoad() {
        
        andicatingView.startAnimating(view: view)
    }
    
    func didLoad<T>(data: T) where T: Decodable, T: Encodable {
        
        andicatingView.stopAnimating()
        guard let data = data as? TodayWeatherForLocationResponse else {
            
            noDataFoundLabel?.isHidden = false
            return
        }
        
        noDataFoundLabel?.isHidden = true
        
        todayWeatherData = data
        currentCityName = data.name
        
        DispatchQueue.main.async { [weak self] in
            
            self?.updateScreenData()
        }
    }
    
    func didFailWith(message: String) {
        
        andicatingView.stopAnimating()
        if message.count > 0 {
            noDataFoundLabel?.text = message
        }
        noDataFoundLabel?.isHidden = false
    }
    
}
