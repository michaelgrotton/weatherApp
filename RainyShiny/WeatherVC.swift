//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by Michael Grotton on 7/11/17.
//  Copyright © 2017 Michael Grotton. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var WeatherData: weatherData!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        WeatherData = weatherData()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            self.WeatherData.downloadWeatherDetails {
                print("******STARTING PRINT 1*******")
                print(self.WeatherData.date)
                print(self.WeatherData.currentTemp)
                print(self.WeatherData.weatherType)
                print(self.WeatherData.cityName)
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        Alamofire.request(FORECAST_URL).responseJSON {response in
            let result = response.result
            if let dict = result.value as? [String: AnyObject]
            {
                if let list = dict["list"] as? [[String:AnyObject]] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
        
    }
    
    func updateMainUI() {
        dateLabel.text = WeatherData.date
        tempLabel.text = String(WeatherData.currentTemp)
        weatherLabel.text = WeatherData.weatherType
        cityLabel.text = "Columbus, OH"
        weatherImage.image = UIImage(named: WeatherData.weatherType)
    }

}

