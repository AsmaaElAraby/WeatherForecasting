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
    
    fileprivate var formattedForcastDataForEach3h: [[WeatherForADayDataModel]]!
    private var doneLoadingData = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        forecastTableView.setContentOffset(CGPoint.zero, animated:false)
        if doneLoadingData == false {
            doneLoadingData = true
            self.setScreenUIProperities()
            self.loadWeatherForecastDataForNextFiveDays()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if formattedForcastDataForEach3h == nil {
            doneLoadingData = false
        }
    }
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //
    //        if let headerView = forecastTableView.tableHeaderView {
    //
    //            headerView.setNeedsLayout()
    //            headerView.layoutIfNeeded()
    //
    //            let height = headerView.systemLayoutSizeFitting(UILayoutFittingExpandedSize).height
    //            var frame = headerView.frame
    //            frame.size.height = height
    //            headerView.frame = frame
    //
    //            forecastTableView.tableHeaderView = headerView
    //
    //        }
    //    }
    
    
    
    /// Set Screen UI Properities
    private func setScreenUIProperities() {
        
        // register table delegate and data source
        self.forecastTableView.delegate = self
        self.forecastTableView.dataSource = self
        
        forecastTableView.estimatedRowHeight = 90
        forecastTableView.rowHeight = UITableViewAutomaticDimension
        
        // register table cell to the table view
        self.forecastTableView.register(UINib(nibName: "WeatherSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherSummaryTableViewCell")
        self.forecastTableView.register(UINib(nibName: "WeatherSummaryHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherSummaryHeaderTableViewCell")
    }
    
    /// Load the screen data
    private func loadWeatherForecastDataForNextFiveDays() {
        
        let controller = WeatherForecastController(viewController: self)
        controller.setDelegate(delegate: self)
        controller.loadForecastDataForCurrentLocation()
    }
    
}


extension ForecastViewController: WeatherForecastDelegate {
    
    /// MARK: WeatherForecastDelegate Handling
    
    func didLoadData<T>(data: T) where T : Decodable, T : Encodable {
        
        guard let data = data as? WeatherForecastForLocationResponse, (data.listOfDays != nil && (data.listOfDays?.count)! > 0 ) else {
            
            // No Data Found
            self.noDataFoundLabel?.isHidden = false
            forecastTableView.isHidden = true
            return
        }
        
        forecastTableView.isHidden = false
        self.noDataFoundLabel?.isHidden = true
        
        self.screenTitleLabel.text = data.cityData?.name
        
        self.formattedForcastDataForEach3h = WeatherForecastController.formDateIntoListOfSubDaysLists(data: data.listOfDays!)
        
        DispatchQueue.main.async {
            
            self.animateTable(tableView: self.forecastTableView, animateDuration: 0)
        }
    }
    
    func didFail(message: String) {
        
        if message.count > 0 {
            self.noDataFoundLabel?.text = message
        }
        self.noDataFoundLabel?.isHidden = false
        self.forecastTableView.isHidden = true
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    /// MARK: Table view delegate and data source handling
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryHeaderTableViewCell") as? WeatherSummaryHeaderTableViewCell
        let session = formattedForcastDataForEach3h[section]
        headerCell?.setCellData(cellData: Date.isToday(timeInterval: TimeInterval(session.first!.dateTimeStamp)) ? "Today" : session.first?.dateDay ?? "")
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryTableViewCell") as? WeatherSummaryTableViewCell
        
        let session = formattedForcastDataForEach3h[indexPath.section][indexPath.row]
        weatherCell?.setCellData(cellData: session)
        weatherCell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        //        if formattedForcastDataForEach3h[indexPath.section].count - 1 == indexPath.row {
        //            weatherCell?.separatorVisable(false)
        //        }
        
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
