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
    
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        if let name = nameTextField.text {
            
            delegate?.addData(agePicker.selectedRow(inComponent: 0),name)
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    var ageList = [Int]()

    @IBOutlet weak var mainStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...100{
            ageList.append(i)
        }
        agePicker.dataSource =  self
        agePicker.delegate = self
        nameTextField.delegate = self
    
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        
            let height:CGFloat = mainStackView.frame.height
            let screen = self.view.superview!.bounds
            let frame = CGRect(x: 0, y: 0, width:self.view.bounds.width, height: height)

            let y = (screen.size.height - frame.size.height) 
            let mainFrame = CGRect(x: view.frame.origin.x, y: y, width: frame.size.width, height: frame.size.height)

            self.view.frame = mainFrame

        
    }
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
