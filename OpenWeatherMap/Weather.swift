//
//  Weather.swift
//  OpenWeatherMap
//
//  Created by John Goh on 23/3/19.
//  Copyright © 2019 John Goh. All rights reserved.
//
import UIKit
import CoreData

extension Weather{
    func configure(weatherData: Weather, rawData: [String: Any]) {
        weatherData.dateUnix = rawData["dt"] as? Double ?? 0
        
        if let main = rawData["main"] as? [String: Double]{
            weatherData.temperature = main["temp"] ?? 0
            weatherData.temperatureMax = main["temp_max"] ?? 0
            weatherData.temperatureMin = main["temp_min"] ?? 0
            weatherData.humidity = main["humidity"] ?? 0
            weatherData.pressure = main["pressure"] ?? 0
            weatherData.pressureSea = main["sea_level"] ?? 0
            weatherData.pressureGround = main["grnd_level"] ?? 0
        }
        
        if let weatherArray = rawData["weather"] as? [[String: Any]],
            weatherArray.count > 0{
            let weather = weatherArray[0]
            weatherData.weatherId = weather["id"] as? Int16 ?? 0
            weatherData.weatherTitle = weather["main"] as? String
            weatherData.weatherDescription = weather["description"] as? String
            weatherData.weatherIcon = weather["icon"] as? String
        }
        if let cloudsDict = rawData["clouds"] as? [String: Double]{
            weatherData.cloudiness = cloudsDict["all"] ?? 0
        }
        
        if let wind = rawData["wind"] as? [String: Double]{
            weatherData.windSpeed = wind["speed"] ?? 0
            weatherData.windDirection = wind["deg"] ?? 0
        }
    }
}
