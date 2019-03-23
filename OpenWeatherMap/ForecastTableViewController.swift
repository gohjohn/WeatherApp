//
//  ForecastTableViewController.swift
//  OpenWeatherMap
//
//  Created by John Goh on 23/3/19.
//  Copyright © 2019 John Goh. All rights reserved.
//

import UIKit
import CoreData

class ForecastTableViewController: UITableViewController {
    
    var isLoading = false
    var data : [Weather] = []
    var expandedSections = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh("")
    }
    @IBAction func refresh(_ sender: Any) {
        guard !isLoading else { return }
        expandedSections.removeAll()
        isLoading = true
        loadSavedData()
        Api.getWeather(success: { (data) in
            DispatchQueue.main.async {
                for item in data{
                    let weatherData = Weather(context: AppDelegate.getContext())
                    weatherData.configure(weatherData: weatherData, rawData: item)
                }
                AppDelegate.saveContext()
                self.isLoading = false
                self.loadSavedData()
            }
        }) { (errorMessage) in
            DispatchQueue.main.async {
                self.isLoading = false
                let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                self.loadSavedData()
            }
        }
    }
    
    func loadSavedData() {
        let fetchRequest = NSFetchRequest<Weather>(entityName: "Weather")
        let sort = NSSortDescriptor(key: "dateUnix", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let threeHoursAgo = Date().addingTimeInterval(-3 * 60 * 60)
        fetchRequest.predicate = NSPredicate(format: "dateUnix > %f", threeHoursAgo.timeIntervalSince1970)

        do {
            data = try AppDelegate.getContext().fetch(fetchRequest)
            print("Got \(data.count) objects")
            tableView.reloadData()
        } catch {
            print("Fetch failed")
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
        let weatherData = self.data[indexPath.section - 1]
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Summary", for: indexPath)
            let dateLabel = cell.viewWithTag(101) as! UILabel
            let weatherLabel = cell.viewWithTag(102) as! UILabel
            let temperatureLabel = cell.viewWithTag(103) as! UILabel
            let imageView = cell.viewWithTag(104) as! UIImageView
            
            if weatherData.dateUnix > 0{
                let date = Date(timeIntervalSince1970: weatherData.dateUnix)
                dateLabel.text = Misc.dateFormatter.string(from: date)
            }else { dateLabel.text = "-" }
            
            temperatureLabel.text = String(format:"%.1f °C", weatherData.temperature)
            
            weatherLabel.text = weatherData.weatherDescription?.capitalizingFirstLetter() ?? "-"
            imageView.image = nil
            if let weatherIconString = weatherData.weatherIcon{
                let imageUrlString = String(format:"https://openweathermap.org/img/w/%@.png", weatherIconString)
                if let imageUrl = URL(string: imageUrlString){
                    imageView.load(url: imageUrl)
                }
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
            
            temperatureLabel.text = String(format:"%.1f °C", weatherData.temperature)
            maxTemperatureLabel.text = String(format:"%.1f °C", weatherData.temperatureMax)
            minTemperatureLabel.text = String(format:"%.1f °C", weatherData.temperatureMin)
            humidityLabel.text = String(format:"%.1f%%", weatherData.humidity)
            cloudinessLabel.text = String(format:"%.1f%%", weatherData.cloudiness)
            windLabel.text = String(format:"%.1fm/s %@", weatherData.windSpeed, Misc.directionToString(direction: weatherData.windDirection))
            
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
