//
//  Location.swift
//  RainyShiny
//
//  Created by Michael Grotton on 7/12/17.
//  Copyright © 2017 Michael Grotton. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
