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
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
            let sector = Sector(context: context)
            saveSector(sector)
            print("Creating new zone")
        }
    }
    
    private func saveSector(_ sector: Sector) {
        sector.days = Date()
        sector.descriptionOfZone = zoneDescriptionTextView.text
        sector.name = zoneNameTextField.text
        sector.uniqueID = Int16(zoneID)
        
        if let image = zoneImage.image {
            guard let data = UIImagePNGRepresentation(image) else {
                fatalError()
            }
            sector.image = data
        }
        
        do {
            try context.save()
        } catch {
            fatalError("Could not save data: \(error)")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        zoneImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
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






