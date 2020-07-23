//
//  TimerViewController.swift
//  Focus-ios
//
//  Created by 夏英浩 on 7/21/20.
//  Copyright © 2020 夏英浩. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var itemPicker: UIPickerView!
    var itemArray = ["Swift", "LeetCode", "English Interview"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemPicker.dataSource = self
        self.itemPicker.delegate = self

    }
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Focus Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //when press add item
            //print("successful")
            var newItem = ""
            
            newItem = textField.text!
            self.itemArray.append(newItem)
            self.itemPicker.reloadAllComponents()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return itemArray.count
    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return itemArray[row]
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label:UILabel
        
        if let v = view as? UILabel{
            label = v
        }else{
            label = UILabel()
        }
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 25)
        label.text = itemArray[row]
        
        return label
    }
    
}
