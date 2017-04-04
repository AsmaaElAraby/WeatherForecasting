//
//  WeatherForecastModelTest.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather_Forecasting

class WeatherForecastModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        LocationManager.shared.getCurrentLocation(onSuccess: { (location: CLLocation) in
//            
//            print(location)
//        }) { (error: String) in
//            
//            print(error)
//        }
        
        
        /*let request = WeatherForecastRequest(latitude: "20430", longitude: "87382", NumberOfDays: "8")
//        print(request.asString())

        let model = WeatherForecastModel()
        model.getWeatherDataForLocationRequest(request: request, onSuccess: { (response: WeatherForecastForLocationResponse?) in
            
            print(response)
            
        }) { (error: String) in
            
            print(error)
        }*/
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
