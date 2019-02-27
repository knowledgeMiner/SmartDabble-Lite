//
//  WeatherViewController.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 2/24/19.
//  Copyright © 2019 Mamajonov Elbek. All rights reserved.
//

import Foundation
import UIKit

struct JSONData: Decodable {
    var location: Location?
    var current: Current?
}

struct Location: Decodable {
    var name: String
}

struct Current: Decodable {
    var temp_c: Int
    var humidity: Int
    var condition: Condition?
}

struct Condition: Decodable {
    var text: String
    var icon: String
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.apixu.com/v1/forecast.json?key=2e35c47a1d784ce49a6154202192102&q=Tashkent"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                
                let jsonData = try JSONDecoder().decode(JSONData.self, from: data)
                
                DispatchQueue.main.async {
                    self.temperature.text = (jsonData.current?.temp_c.toString())! + " ℃"
                    self.humidity.text = "humidity: " + (jsonData.current?.humidity.toString())! + "%"
                }
                
                if let iconAddress = jsonData.current?.condition?.icon {
                    guard let iconID = iconAddress.iconID else { return }
                    
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(named: iconID)
                    }
                }
                
            } catch let jsonErr {
                print("ERROR", jsonErr)
            }
            
            }.resume()
        
        
    }
    
}

extension String {
    
    var iconID: String? {
        guard let slashIndex = self.lastIndex(of: "/") else { return nil }
        
        let startIndex = self.index(slashIndex, offsetBy: 1)
        
        let lastIndex = self.index(startIndex, offsetBy: 3)
        
        return String(self[startIndex..<lastIndex])
    }
    
}

extension Int {
    func toString () -> String {
        return "\(self)"
    }
}
