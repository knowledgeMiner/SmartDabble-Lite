//
//  ZonesTableViewController.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 11/1/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit
import CoreData

class ZonesTableViewController: UITableViewController {

    var sectors: [Sector]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Table view data source
    var sections = ["Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6", "Zone 7", "Zone 8", "Zone 9", "Zone 10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        
        let request: NSFetchRequest<Sector> = Sector.fetchRequest()
        
        do {
            sectors = try context.fetch(request)
            print("Count: \(sectors?.count ?? 0)")
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZoneCell", for: indexPath) as! ZoneCellTableViewCell

        if let sector = findSectorFor(id: indexPath.row) {
            cell.zoneTextLabel.text = sector.name
            cell.zoneImage?.image = (sector.image == nil) ? #imageLiteral(resourceName: "defaultImage") : UIImage(data: (sector.image)!)
        } else {
            cell.zoneTextLabel.text = sections[indexPath.row]
            cell.zoneImage?.image = #imageLiteral(resourceName: "defaultImage")
        }

        return cell
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let zoneEditor = segue.destination as? ZoneEditorViewController, let indexPath = tableView.indexPathForSelectedRow {
                if let sector = findSectorFor(id: indexPath.row) {
                    zoneEditor.selectedSector = sector
                }
                
                zoneEditor.zoneID = indexPath.row
        }
    }
    
    private func findSectorFor(id: Int) -> Sector? {
        var sector: Sector?
        
        sectors?.forEach({ (currentSector) in
            if currentSector.uniqueID == id {
                sector = currentSector
            }
        })
        
        return sector
    }
 

}
