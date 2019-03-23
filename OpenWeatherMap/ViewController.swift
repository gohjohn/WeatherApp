//
//  ViewController.swift
//  OpenWeatherMap
//
//  Created by John Goh on 22/3/19.
//  Copyright © 2019 John Goh. All rights reserved.
//

/*
 I will document my thought process and what I did.
 1) Explore OpenWeatherMaps API first. I need to understand what data I'm dealing with
 2) Signed up for API key - Takes a few hours for API key to activate
 3) Explored a few weather UIs
    i) Desktop Google Chrome weather search: Graph (3hourly) with 3 versions for temp,precipation,wind
        Temperature graph have clickable nodes
        On click, the data changes (temp,weather,precipation,humidity,wind)
    ii) iPad Google Chrome weather search: Slider with time
        On tap, the data changes (temp,weather,precipation,humidity,wind)
    iii) Android Google Chrome weather search: same as iPad
    iv) Android Google Search App (Portrait only): 3 tabs - Today, Tomorrow, 10 days
        1) Today and Tomorrow tab:
            Summary of day on top. Hourly temperature graph and weather at bottom.
            Scroll horizontally for later timings.
            Scroll vertically for more details for day
        2) 10 days tab:
            TableView with 10 rows. Each row has date, chance of rain, weather, max and min temperature
            On expand, details are shown: wind, humidity, UV index, chance of rain, sunrise/sunset
            Also shows horizontally scrollable icons for weather and temperature every 2 hours
    v) Android Weather App (Xiaomi)
    vi) iPad Yahoo Weather App
 
    Have an idea of what I wanna do now. Will take elements from each app to use
 
 4) Conceptualize design:
    From the apps I realize that the most impt thing is to show the current weather for now/today.
    It makes sense. When I open a weather app thats what I wanna see.
    Hence that will be the first thing the user sees.
 
    Then a second screen for the forecast. Thinking of a simple one like the 10 day tab on Google Search App.
 
    I will work on the 2nd screen first. Since time that will fulfil the requirements first.
 
 5) In my head, the priorities are :
    a) Show my thought process. (hence these comments)
    b) API calling.
    c) API to display in on 2nd page, the forecast page
    c) Store data. Will use something simple for now.
    d) Design good UI/UX. First screen, the current weather page
    e) Test iPad and iPhone UI
    e) If I have time, write some tests
 
 6) Right now, am reaching the 1 hour mark
 
 
 
 
 
 Note to self, possible UI component: https://medium.com/@anitaa_1990/create-a-horizontal-paging-uiscrollview-with-uipagecontrol-swift-4-xcode-9-a3dddc845e92

 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

