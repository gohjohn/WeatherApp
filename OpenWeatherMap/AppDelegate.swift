//
//  AppDelegate.swift
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
 
 6) Right now, am reaching the 1 hour mark. Commiting code.
 
 7) 1h 45min mark. I just finished pulling the data.
 
 8) 2h 10min mark. I realized I need another screen.
 The previous idea was a screen that summarized weather per day.
 I need a 3hr forecast screen where i will just put all the data.
 Commiting code.
 
 9) 3h 30min mark. I am more or less done with Forecast Screen.
 I think there is no time to do my desired Forecast summary screen where I group according to days
 
 Current TODO:
 - format the date string to SGT
 - Data persistance
 - Front Page
 Commiting code
 
 10) Forecast Screen Done. Cleaned up code. Commiting. Next is Core data. (i honestly have little exp with core data)
 
 
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

