//
//  ZoneEditorViewController.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 11/8/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit

class ZoneEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var zoneImage: UIImageView!
    
    @IBOutlet weak var zoneNameTextField: UITextField!
    
    @IBOutlet weak var zoneDescriptionTextView: UITextView!

    @IBOutlet weak var cameraButton: UIButton! {
        didSet {
            cameraButton.isHidden = true
        }
    }

    var zoneID = 0
    
    // core data staff
    
    var selectedSector: Sector?
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        cameraButton.isHidden = !editing
        zoneDescriptionTextView.isUserInteractionEnabled = editing
        zoneNameTextField.isUserInteractionEnabled = editing
        
        if !editing, zoneNameTextField.text != nil {
            updateZone()
        }
    }
    
    private func updateZone() {
        if let sector = selectedSector {
            saveSector(sector)
            print("Updating old zone")
        } else {
            let sector = Sector(context: FetchRequest.context)
            saveSector(sector)
            print("Creating new zone")
        }
    }
    
    private func saveSector(_ sector: Sector) {
        sector.descriptionOfZone = zoneDescriptionTextView.text
        sector.name = zoneNameTextField.text
        sector.uniqueID = Int16(zoneID)
        sector.daysOfweek = daysOfWeek()
        
        if let image = zoneImage.image {
            guard let data = image.pngData() else {
                fatalError()
            }
            sector.image = data
        }
        
        FetchRequest.saveContext()
    }
    
    private func daysOfWeek() -> Week {
        let week = Week(context: FetchRequest.context)
        week.monday = false
        week.tuesday = false
        week.wednesday = false
        week.thursday = false
        week.friday = false
        week.saturday = false
        week.sunday = false
        return week
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        picker.dismiss(animated: true, completion: nil)
        zoneImage.image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
    }
    
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        zoneNameTextField.delegate = self
        zoneDescriptionTextView.delegate = self
     
        setView()
    }
    
    private func setView() {
        if let sector = selectedSector {
            zoneNameTextField.text = sector.name
            zoneDescriptionTextView.text = sector.descriptionOfZone
            if let data = sector.image {
                zoneImage.image = UIImage(data: data)
            }
        } else {
            zoneNameTextField.text = "Zone \(zoneID+1)"
            zoneDescriptionTextView.text = "Description"
        }
    }

}

extension ZoneEditorViewController: UITextFieldDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

extension ZoneEditorViewController: UITextViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}







// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
