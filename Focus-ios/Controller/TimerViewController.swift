//
//  TimerViewController.swift
//  Focus-ios
//
//  Created by 夏英浩 on 7/21/20.
//  Copyright © 2020 夏英浩. All rights reserved.
//

import UIKit
import CoreData
class TimerViewController: UIViewController {

    let calendar = Calendar.current
    var clickedDate = Date()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [UserItem]()
    var timerEnable = false
    var textField = UITextField()
    var setTime = TimePeriod()
    
    @IBOutlet weak var itemPicker: UIPickerView!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTime.minutes = 25
        setTime.seconds = 0
        loadItems()
        self.itemPicker.dataSource = self
        self.itemPicker.delegate = self
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
    }
    @IBAction func minusClicked(_ sender: UIButton) {
    }
    //MARK: - add Items
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
       
        let alert = UIAlertController(title: "Add New Focus Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = UserItem(context: self.context)
            newItem.name = self.textField.text
            newItem.time = 0.0
            self.itemArray.append(newItem)
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            self.textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Timer Methods
    
    @IBAction func timeButtonPressed(_ sender: UIButton) {
        
        if timerEnable == false{
            
            clickedDate = Date()
            
            let components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: clickedDate)

            print("clicked date: hour: \(components.hour!), minute: \(components.minute!), seconds: \(components.second!)")
            timerEnable = true
            performSegue(withIdentifier: "goToTimer", sender: self)
        }else{
            timer.invalidate()
            let rightNow = Date()
            let components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: rightNow)
            
            print("clicked date: hour: \(components.hour!), minute: \(components.minute!), seconds: \(components.second!)")
            
            let timePeriod = calendar.dateComponents([.second], from: clickedDate, to: rightNow)
            
            print(timePeriod.second!)
            timerEnable = false
        }
    }
    
    //MARK: - CoreData Methods
    func saveItems() {
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        itemPicker.reloadAllComponents()
    }
    
    func loadItems(){
        let request : NSFetchRequest<UserItem> = UserItem.fetchRequest()
        
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context: \(error)")
        }
        itemPicker.reloadAllComponents()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTimer"{
            let destinationVC = segue.destination as! FocusViewController
            let index = itemPicker.selectedRow(inComponent: 0)
            destinationVC.targetString = itemArray[index].name
            destinationVC.clickedDate = self.clickedDate
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
        label.text = itemArray[row].name
        return label
    }
}
