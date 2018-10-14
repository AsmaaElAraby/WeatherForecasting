//
//  ForecastViewController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class ForecastViewController: BaseViewController {
    
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet var forecastTableView: UITableView!
    
    lazy var andicatingView: AndicatingView = {
        
        return AndicatingView()
    }()
    
    fileprivate var formattedForcastDataForEach3h: [[WeatherForADayDataModel]]!
    private var doneLoadingData = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        forecastTableView.setContentOffset(CGPoint.zero, animated:false)
        if doneLoadingData == false {
            doneLoadingData = true
            setScreenUIProperities()
            loadWeatherForecastDataForNextFiveDays()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if forecastTableView.tableHeaderView != nil {
         
            forecastTableView.tableHeaderView?.frame = CGRect(x: 0, y: forecastTableView.tableHeaderView?.frame.origin.y ?? 0, width: forecastTableView.frame.size.width, height: forecastTableView.tableHeaderView?.frame.size.height ?? 0)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if formattedForcastDataForEach3h == nil {
            doneLoadingData = false
        }
    }
    
    /// Set Screen UI Properities
    private func setScreenUIProperities() {
        
        // register table delegate and data source
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        
        forecastTableView.estimatedRowHeight = 90
        forecastTableView.rowHeight = UITableViewAutomaticDimension
        
        // register table cell to the table view
        forecastTableView.register(UINib(nibName: "WeatherSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherSummaryTableViewCell")
        forecastTableView.register(UINib(nibName: "WeatherSummaryHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherSummaryHeaderTableViewCell")
    }
    
    /// Load the screen data
    private func loadWeatherForecastDataForNextFiveDays() {
        
        let controller = WeatherForecastController()
        controller.setDelegate(delegate: self)
        controller.loadForecastWeatherForCurrentLocation()
    }
    
}

extension ForecastViewController: WeatherForecastDelegate {
    
    /// MARK: WeatherForecastDelegate Handling
    
    func willLoad() {
        
        andicatingView.startAnimating(view: self.view)
    }
    
    func didLoad<T>(data: T) where T: Decodable, T: Encodable {
        
        andicatingView.stopAnimating()
        
        guard let data = data as? WeatherForecastForLocationResponse, (data.listOfDays != nil && (data.listOfDays?.count)! > 0 ) else {
            
            // No Data Found
            noDataFoundLabel?.isHidden = false
            forecastTableView.isHidden = true
            return
        }
        
        forecastTableView.isHidden = false
        noDataFoundLabel?.isHidden = true
        
        screenTitleLabel.text = data.cityData?.name
        
        let controller = WeatherForecastController()
        formattedForcastDataForEach3h = controller.listOfSubDaysFrom(data: data.listOfDays!)
        
        DispatchQueue.main.async { [weak self] in
            
            if self?.forecastTableView != nil {
                self?.animateTable(tableView: (self?.forecastTableView)!, animateDuration: 0)
            }
        }
    }
    
    func didFailWith(message: String) {
        
        andicatingView.stopAnimating()
        
        if message.count > 0 {
            noDataFoundLabel?.text = message
        }
        noDataFoundLabel?.isHidden = false
        forecastTableView.isHidden = true
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    /// MARK: Table view delegate and data source handling
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryHeaderTableViewCell") as? WeatherSummaryHeaderTableViewCell
        let session = formattedForcastDataForEach3h[section]
        headerCell?.setCellData(cellData: Date.isToday(timeInterval: TimeInterval(session.first!.dateTimeStamp)) ? "Today" : session.first?.dateDay ?? "")
        headerCell?.separatorInset = UIEdgeInsets.zero
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryTableViewCell") as? WeatherSummaryTableViewCell
        
        let session = formattedForcastDataForEach3h[indexPath.section][indexPath.row]
        weatherCell?.setCellData(cellData: session)
        weatherCell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return weatherCell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if formattedForcastDataForEach3h == nil || formattedForcastDataForEach3h.count <= 0 {
            return 0
        }
        return formattedForcastDataForEach3h.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if formattedForcastDataForEach3h == nil || formattedForcastDataForEach3h[section].count <= 0 {
            return 0
        }
        return formattedForcastDataForEach3h[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
}
