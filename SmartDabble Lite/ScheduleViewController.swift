//
//  ScheduleViewController.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 11/21/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet var dayButtons: [UIButton]! {
        didSet {
            dayButtons.forEach { (button) in
                button.backgroundColor = .darkGray
            }
        }
    }
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBAction func onDayTap(_ sender: UIButton) {
        updateDayOfWeek(sender.tag)
    }
    
    var sectors: [Sector]? {
        didSet {
            guard let zones = sectors else { return }
            checkmarks = Array(repeating: false, count: zones.count)
        }
    }
    
    let cellIdentifier = "scheduleCell"
    
    var checkmarks = [Bool]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FetchRequest.loadData()
        sectors = FetchRequest.sectors
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayFunc()
        
        /// set
        let isSwitched = false
        UserDefaults.standard.set(isSwitched, forKey: "Schedule work")
    
        
        /// get
        UserDefaults.standard.bool(forKey: "Schedule work")
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.layoutIfNeeded()
        dayFunc()
    }
    
    func dayFunc() {
        let width = self.dayButtons[0].bounds.width
        height.constant = width
        print(width)
        dayButtons.forEach { (button) in
            button.layer.cornerRadius = width/2
        }
    }

}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectors?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = sectors?[indexPath.row].name
        cell.accessoryType = (checkmarks[indexPath.row]) ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        checkmarks[indexPath.row] = !checkmarks[indexPath.row]
        
        let selectedRows = numberOfSelectedRows()
        
        if  selectedRows == 0 || selectedRows > 1 {
            reset()
        } else if let sector = sectors?[indexPath.row], let week = sector.daysOfweek {
            updateButtonLayoutFor(week: week)
        }
        
        tableView.reloadData()
    }
    
    func updateButtonLayoutFor(week: Week) {
        for button in dayButtons {
            switch button.tag {
            case 0:
                updateButtonBackgrounColor(button, isActive: week.monday)
            case 1:
                updateButtonBackgrounColor(button, isActive: week.tuesday)
            case 2:
                updateButtonBackgrounColor(button, isActive: week.wednesday)
            case 3:
                updateButtonBackgrounColor(button, isActive: week.thursday)
            case 4:
                updateButtonBackgrounColor(button, isActive: week.friday)
            case 5:
                updateButtonBackgrounColor(button, isActive: week.saturday)
            case 6:
                updateButtonBackgrounColor(button, isActive: week.sunday)
            default:
                break
            }
        }
    }
    
    func updateButtonBackgrounColor(_ button: UIButton, isActive: Bool) {
        button.backgroundColor = (isActive) ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : .darkGray
    }
    
    func updateDayOfWeek(_ day: Int) {
        
        for index in 0..<checkmarks.count {
            
            if checkmarks[index], let sector = sectors?[index], let week = sector.daysOfweek {
                switch day {
                case 0:
                    week.monday = !week.monday
                case 1:
                    week.tuesday = !week.tuesday
                case 2:
                    week.wednesday = !week.wednesday
                case 3:
                    week.thursday = !week.thursday
                case 4:
                    week.friday = !week.friday
                case 5:
                    week.saturday = !week.saturday
                case 6:
                    week.sunday = !week.sunday
                default:
                    break
                }
                
                FetchRequest.saveContext()
                updateButtonLayoutFor(week: week)
            }
        }
    }
    
    private func numberOfSelectedRows() -> Int {
        var count = 0
        for checkmark in checkmarks {
            count = (checkmark) ? (count+1) : count
        }
        
        return count
    }
    
    private func reset() {
        dayButtons.forEach { (button) in
            button.backgroundColor = .darkGray
        }
        
        guard let sectors = sectors else { return }
        
        for index in 0..<checkmarks.count {
            if checkmarks[index], let week = sectors[index].daysOfweek {
                week.monday = false
                week.tuesday = false
                week.wednesday = false
                week.thursday = false
                week.friday = false
                week.saturday = false
                week.sunday = false
            }
        }
    }
    
}












