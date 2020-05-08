//
//  ActionViewController.swift
//  HeartApp
//
//  Created by Tareq Rahman Joy on 4/5/20.
//  Copyright © 2020 Tareq Rahman Joy. All rights reserved.
//

import Foundation
import UIKit


class ActionViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var agePicker: UIPickerView!
    
    var delegate: AddDataToList?
    var info : InfoClass?
    var infoId : Int?
    var editMode = false
    
    
    @objc @IBAction func cancelButtonClicked(_ sender: UIButton) {
        if editMode {
            if let name = nameTextField.text {
                if (name != info?.name || agePicker.selectedRow(inComponent: 0) != info?.age){

                    showCancelConfirmDlg()
                } else {
                    navigationController?.popViewController(animated: true)
                }
            } else {
                navigationController?.popViewController(animated: true)
            }
            
        } else {
            if let name = nameTextField.text {
                if !name.trimmingCharacters(in: .whitespaces).isEmpty{
                    showCancelConfirmDlg()
                } else {
                    navigationController?.popViewController(animated: true)
                }
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    func showCancelConfirmDlg(){
        let alert = UIAlertController(title: "Alert", message: "Some data have been changed, do you want to cancel without saving?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        if let name = nameTextField.text {
            let goodName = name.trimmingCharacters(in: .whitespaces)
            if goodName.count < 5{
                if editMode {
                    delegate?.updateData(agePicker.selectedRow(inComponent: 0),goodName, index : infoId!)
                } else {
                    delegate?.addData(agePicker.selectedRow(inComponent: 0),goodName)
                }
                navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Alert", message: "Invalid or Too short name!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    var ageList = [Int]()
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        for i in 0...100{
            ageList.append(i)
        }
        agePicker.dataSource =  self
        agePicker.delegate = self
        nameTextField.delegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.cancelButtonClicked(_:)))
        
        if let safeInfo = info {
            agePicker.selectRow(safeInfo.age, inComponent: 0, animated: true)
            nameTextField.text = safeInfo.name
            editMode = true
            
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        super.viewWillDisappear(animated)
    }
    /*
     override func viewWillLayoutSubviews() {
     super.viewWillLayoutSubviews()
     
     
     let height:CGFloat = mainStackView.frame.height
     let screen = self.view.superview!.bounds
     let frame = CGRect(x: 0, y: 0, width:self.view.bounds.width, height: height)
     
     let y = (screen.size.height - frame.size.height)
     let mainFrame = CGRect(x: view.frame.origin.x, y: y, width: frame.size.width, height: frame.size.height)
     
     self.view.frame = mainFrame
     
     
     }*/
}

extension ActionViewController: UIPickerViewDelegate{
    
}

extension ActionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(ageList[row])
    }
    
}

extension ActionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
