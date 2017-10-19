//
//  constants.swift
//  RainyShiny
//
//  Created by Michael Grotton on 7/12/17.
//  Copyright © 2017 Michael Grotton. All rights reserved.
//

import Foundation

let baseURL = "api.openweathermap.org/data/2.5/weather?"
let latitude = "lat="
let longitude = "&lon="
let appID = "&appid="
let apiKey = "4e434c4cb4416d4989774e48335068e7"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=4e434c4cb4416d4989774e48335068e7"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=4e434c4cb4416d4989774e48335068e7"
