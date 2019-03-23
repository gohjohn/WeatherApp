//
//  Misc.swift
//  OpenWeatherMap
//
//  Created by John Goh on 23/3/19.
//  Copyright © 2019 John Goh. All rights reserved.
//

import UIKit


class Misc{
    class func directionToString(direction:Double) -> String {
        var offsetDirection = direction + 22.5 //    360 / 8directions / 2
        while offsetDirection < 0 { offsetDirection += 360 }
        let directions = ["North","NorthEast","East","SouthEast","South","SouthWest","West","NorthWest"]
        var index = Int(offsetDirection / 45)
        if index >= directions.count { index = 0 } //Shouldn't happen
        return directions[index]
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
