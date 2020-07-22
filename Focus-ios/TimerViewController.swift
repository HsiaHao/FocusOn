//
//  TimerViewController.swift
//  Focus-ios
//
//  Created by 夏英浩 on 7/21/20.
//  Copyright © 2020 夏英浩. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    var itemArray = ["Swift", "LeetCode", "English Interview"]
    var minutes = 30
    var seconds = 0
    var timerEnable = false
    
    @IBOutlet weak var itemPicker: UIPickerView!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemPicker.dataSource = self
        self.itemPicker.delegate = self
        let timeString = String(format: "%02d : %02d", minutes, seconds )// 007
        //let timeString = "\(minutes) : \(seconds)"
        timeLabel.text = timeString

    }
    
    @objc func updateUI()
    {
        if minutes > 0 && seconds == 0{
            minutes -= 1
            seconds = 59
        }else if seconds > 0{
            seconds -= 1
        }else if minutes == 0 && seconds == 0{
            timer.invalidate()
            print("Time Out")
        }
        let timeString = String(format: "%02d : %02d", minutes, seconds)
        timeLabel.text = timeString
    }
    //MARK: - add Items
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
    
    //MARK: - Timer Methods
    
    @IBAction func timeButtonPressed(_ sender: UIButton) {
        if timerEnable == false{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
            timerButton.setTitle("Stop", for: .normal)
            timerEnable = true
        }else{
            timerButton.setTitle("Start", for: .normal)
            timer.invalidate()
            timerEnable = false
        }
    }
    
}
    
//MARK: - UIPickerView Methods
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
