//
//  Api.swift
//  OpenWeatherMap
//
//  Created by John Goh on 23/3/19.
//  Copyright © 2019 John Goh. All rights reserved.
//

import Foundation
class Api{
    static func getWeather(success: @escaping ([[String:Any]])->Void, failure: @escaping (String) -> Void) {
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?id=1880252&units=metric&APPID=6c6d6fe59a3950b1468e551f71d7e81b"
        guard let url = URL(string: urlString) else {
            failure("Invalid URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    failure(error?.localizedDescription ?? "Response Error")
                    return
            }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                guard let json = jsonResponse as? [String: Any] else {
                    failure("Invalid Response")
                    return
                }
                if let code = json["cod"] as? String, //Most message codes are String
                    code != "200"{
                    failure(json["message"] as? String ?? "Invalid Response code")
                    return
                }
                if let code = json["cod"] as? Int, //401 error message code is Int (wth openweathermap)
                    code != 200{
                    failure(json["message"] as? String ?? "Invalid Response code")
                    return
                }
                if let validData = json["list"] as? [[String:Any]]{
                    success(validData)
                }else{
                    failure("Invalid Response format")
                }
            } catch let parsingError {
                failure(parsingError.localizedDescription)
            }
        }
        task.resume()
        
    }
}
