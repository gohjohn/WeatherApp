//
//  ForecastFullTableViewController.swift
//  OpenWeatherMap
//
//  Created by John Goh on 23/3/19.
//  Copyright © 2019 John Goh. All rights reserved.
//

import UIKit

class ForecastFullTableViewController: UITableViewController {
    
    var isLoading = false
    var data : [[String:Any]] = []
    var expandedSections = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh("")
    }
    @IBAction func refresh(_ sender: Any) {
        guard !isLoading else { return }
        expandedSections.removeAll()
        isLoading = true
        self.tableView.reloadData()
        Api.getWeather(success: { (data) in
            self.data = data
            NSKeyedArchiver.archivedData(withRootObject: <#T##Any#>)
            self.isLoading = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (errorMessage) in
            self.isLoading = false
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isLoading ? 1 : 0
        }
        guard section - 1 < data.count else{
            return 0
        }
        return expandedSections.contains(section) ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Loading", for: indexPath)
            let spinner = cell.viewWithTag(301) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        }
        guard indexPath.section - 1 < data.count else{
            return UITableViewCell()
        }
        let cellData = self.data[indexPath.section - 1]
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Summary", for: indexPath)
            let dateLabel = cell.viewWithTag(101) as! UILabel
            let weatherLabel = cell.viewWithTag(102) as! UILabel
            let temperatureLabel = cell.viewWithTag(103) as! UILabel
            let imageView = cell.viewWithTag(104) as! UIImageView
            
            if let dateInterval = cellData["dt"] as? Double{
                let date = Date(timeIntervalSince1970: dateInterval)
                dateLabel.text = Misc.dateFormatter.string(from: date)
            }else { dateLabel.text = "-" }
            
            if let main = cellData["main"] as? [String: Double],
                let mainTemperature = main["temp"]{
                temperatureLabel.text = String(format:"%.1f °C", mainTemperature)
            } else { temperatureLabel.text = "-" }
            
            if let weather = cellData["weather"] as? [[String: Any]],
                weather.count > 0,
                let weatherDescription = weather[0]["description"] as? String,
                let weatherIconString = weather[0]["icon"] as? String {
                weatherLabel.text = weatherDescription.capitalizingFirstLetter()
                imageView.image = nil
                let imageUrlString = String(format:"https://openweathermap.org/img/w/%@.png", weatherIconString)
                if let imageUrl = URL(string: imageUrlString){
                    imageView.load(url: imageUrl)
                }
                
            }else{
                weatherLabel.text = "-"
                imageView.image = nil
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Details", for: indexPath)
            
            let temperatureLabel = cell.viewWithTag(201) as! UILabel
            let maxTemperatureLabel = cell.viewWithTag(202) as! UILabel
            let minTemperatureLabel = cell.viewWithTag(203) as! UILabel
            let humidityLabel = cell.viewWithTag(204) as! UILabel
            let cloudinessLabel = cell.viewWithTag(205) as! UILabel
            let windLabel = cell.viewWithTag(206) as! UILabel
            
            if let main = cellData["main"] as? [String: Double]{
                if let mainTemperature = main["temp"]{
                    temperatureLabel.text = String(format:"%.1f °C", mainTemperature)
                }else { temperatureLabel.text = "-" }
                if let maxTemperature = main["temp_max"]{
                    maxTemperatureLabel.text = String(format:"%.1f °C", maxTemperature)
                }else { maxTemperatureLabel.text = "-" }
                if let minTemperature = main["temp_min"]{
                    minTemperatureLabel.text = String(format:"%.1f °C", minTemperature)
                }else { minTemperatureLabel.text = "-" }
                if let humidity = main["temp"]{
                    humidityLabel.text = String(format:"%.1f%%", humidity)
                }else { humidityLabel.text = "-" }
            }
            if let clouds = cellData["clouds"] as? [String: Double],
                let cloudiness = clouds["all"]{
                cloudinessLabel.text = String(format:"%.1f%%", cloudiness)
            }else { cloudinessLabel.text = "-" }
            if let wind = cellData["wind"] as? [String: Double],
                let windSpeed = wind["speed"],
                let windDirection = wind["deg"]{
                windLabel.text = String(format:"%.1fm/s %@", windSpeed, Misc.directionToString(direction: windDirection))
            }else { windLabel.text = "-" }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 && indexPath.row == 0{
            tableView.deselectRow(at: indexPath, animated: true)
            if expandedSections.contains(indexPath.section){
                tableView.beginUpdates()
                expandedSections.remove(indexPath.section)
                tableView.deleteRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .automatic)
                tableView.endUpdates()
            }else{
                tableView.beginUpdates()
                expandedSections.insert(indexPath.section)
                tableView.insertRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .automatic)
                tableView.endUpdates()
            }
        }else{
            tableView.deselectRow(at: indexPath, animated: false)
            //Nothing should happen
        }
    }
}
