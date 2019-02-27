//
//  FetchRequest.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 2/18/19.
//  Copyright © 2019 Mamajonov Elbek. All rights reserved.
//

import UIKit
import CoreData

class FetchRequest {
    
    static var sectors = [Sector]()
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func loadData() {
    
        let request: NSFetchRequest<Sector> = Sector.fetchRequest()
        
        do {
            sectors = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    static func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
