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

    @IBOutlet weak var cameraButton: UIButton!{
        didSet {
            cameraButton.isHidden = true
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        cameraButton.isHidden = !editing
        zoneDescriptionTextView.isUserInteractionEnabled = editing
        zoneNameTextField.isUserInteractionEnabled = editing
        if !editing {
            let sector = Sector()
            sector.createSector(zoneNameTextField.text!, zoneDescriptionTextView.text!, zoneImage.image!, in: context)
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
    }
    
    // CoreData staff
    private let container = AppDelegate.persistentContainer
    private let context = AppDelegate.viewContext
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZoneEditorViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    /*
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        <#code#>
    }*/
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let sector = Sector()
//        sector.createSector(zoneNameTextField.text!, zoneDescriptionTextView.text!, , in: context)
//    }
    
}

extension ZoneEditorViewController: UITextViewDelegate {
    
}






