//
//  ForecastViewController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class ForecastViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, WeatherForecastDelegate {

    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet var forecastTableView: UITableView!
    
    private var forecastTableDataSource: [WeatherForADayDataModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setScreenUIProperities()
        self.loadWeatherForecastDataForNextSevenDays()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Set Screen UI Properities
    private func setScreenUIProperities() {
        
        // register table delegate and data source
        self.forecastTableView.delegate = self
        self.forecastTableView.dataSource = self
        
        // register table cell to the table view
        self.forecastTableView.register(UINib(nibName: "WeatherSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherSummaryTableViewCell")
    }
    
    /// Load the screen data
    private func loadWeatherForecastDataForNextSevenDays() {
        
        let controller = WeatherForecastController(viewController: self)
        controller.setDelegate(delegate: self)
        controller.loadForecastDataForCurrentLocation()
    }

    
    /// MARK: WeatherForecastDelegate Handling
    
    func didLoadWeatherForecastData(data: WeatherForecastForLocationResponse) {
        
        // check if received data or not
        if data.getListOfDays().count > 0 {
            
            self.screenTitleLabel.text = data.getCityData().getLocationName()
                
            self.forecastTableDataSource = [WeatherForADayDataModel]()
            self.forecastTableDataSource = data.getListOfDays()
            
            DispatchQueue.main.async {
                
                self.animateTable(tableView: self.forecastTableView, animateDuration: 0)
            }
        } else {
            
            // No Data Found
            let controller = WeatherForecastController(viewController: self)
            controller.showErrorMessageAlert(message: "noDataFound")
        }
    }
    
    /// MARK: Table view delegate and data source handling
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryTableViewCell") as? WeatherSummaryTableViewCell
        
        let session = self.forecastTableDataSource[indexPath.row]
        weatherCell?.setCellData(cellData: session)
        weatherCell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return weatherCell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.forecastTableDataSource == nil || self.forecastTableDataSource.count <= 0 {
            return 0
        }
        return self.forecastTableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }

}
