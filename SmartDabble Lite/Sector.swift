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
    
    func createSector(_ name: String, _ description: String?, _ image: UIImage?, in context: NSManagedObjectContext) {
        let sector = try! find(byName: name, in: context) ?? Sector(context: context)
        if image != nil, description != nil {
            sector.name = name
            sector.image = UIImageJPEGRepresentation(image!, 1)
            sector.descriptionOfZone = descriptionOfZone
        } else if image != nil {
            sector.name = name
            sector.image = UIImageJPEGRepresentation(image!, 1)
        } else if description != nil {
            sector.name = name
            sector.descriptionOfZone = descriptionOfZone!
            sector.image = UIImageJPEGRepresentation(#imageLiteral(resourceName: "zones"), 1)
        }
        
    }
    
    private func find(byName name: String, in context: NSManagedObjectContext) throws -> Sector? {
        
        let request: NSFetchRequest<Sector> = Sector.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        let sector = try context.fetch(request)
        return sector.first

    }
    
    
    
    
}
