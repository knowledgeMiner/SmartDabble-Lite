//
//  Sector.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 11/22/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit
import CoreData

class Sector: NSManagedObject {
    
    func createSector(_ name: String?, _ description: String?, _ image: UIImage?, in context: NSManagedObjectContext) {
        let sector = Sector(context: context)
        if name != nil, image != nil, description != nil {
            sector.name = name
            sector.image = UIImageJPEGRepresentation(image!, 1)
            sector.descriptionOfZone = descriptionOfZone
        } else if name != nil, image != nil {
            sector.name = name
            sector.image = UIImageJPEGRepresentation(image!, 1)
        } else if name != nil, description != nil {
            sector.name = name!
            sector.descriptionOfZone = descriptionOfZone!
            sector.image = UIImageJPEGRepresentation(#imageLiteral(resourceName: "zones"), 1)
        }
        
    }
    
    
    
    
}
