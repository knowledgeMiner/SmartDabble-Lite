//
//  File.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 2/25/19.
//  Copyright © 2019 Mamajonov Elbek. All rights reserved.
//

import Foundation

class SDL_API {
    
    
    private var sectorList = [Sector]()
    
    public func getDays () -> [String: String] {
        FetchRequest.loadData()
        sectorList = FetchRequest.sectors
        var waterByDay = [String: String]()
        var wateringDays = ""
        
        for sector in sectorList {
            
            let week = sector.daysOfweek
            if (week?.monday)! {
                wateringDays.append("monday")
            }
            if (week?.tuesday)! {
                wateringDays.append("tuesday,")
            }
            if (week?.wednesday)! {
                wateringDays.append("wednesday,")
            }
            if (week?.thursday)! {
                wateringDays.append("thursday,")
            }
            if (week?.friday)! {
                wateringDays.append("friday,")
            }
            if (week?.saturday)! {
                wateringDays.append("saturday,")
            }
            if (week?.sunday)! {
                wateringDays.append("sunday")
            }
            
            waterByDay[sector.name!] = wateringDays
        }
        
        return waterByDay
    }
    
    public func getZones() -> [String] {
        
        var sectors: [String]?
        
        for zone in sectorList {
            sectors?.append(zone.name!)
        }
        
        return sectors ?? ["no sectors"]
    }
    
}
