//
//  WeatherCell.swift
//  RainyShiny
//
//  Created by Michael Grotton on 7/12/17.
//  Copyright © 2017 Michael Grotton. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = String(forecast.lowTemp)
        highTemp.text = String(forecast.highTemp)
        weatherType.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date
    }

}
