//
//  DataModel.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 11/08/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import Alamo

class DataModel {
    
    private var _date: Double?
    private var _temp: String?
    private var _location: String?
    private var _weather: String?
    typealias JSONStandard = Dictionary<String, AnyObject>
    
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Portland&appid=a7bbbd5e82c675f805e7ae084f742024")!
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let date = Date(timeIntervalSince1970: _date!)
        return (_date != nil) ? "Today, \(dateFormatter.string(from: date))" : "Date Invalid"
    }
    
    var temp: String {
        return _temp ?? "0 °C"
    }
    
    var location: String {
        return _location ?? "Location Invalid"
    }
    
    var weather: String {
        return _weather ?? "Weather Invalid"
    }
    
}
