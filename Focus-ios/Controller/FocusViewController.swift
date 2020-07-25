//
//  FocusViewController.swift
//  Focus-ios
//
//  Created by 夏英浩 on 7/24/20.
//  Copyright © 2020 夏英浩. All rights reserved.
//

import UIKit

class FocusViewController: UIViewController {

    
    var targetString: String?
    var clickedDate: Date?
    let calendar = Calendar.current
    var timer: Timer?
    var timerEnable = true
    var totalTime = TimePeriod()
    var passedTime = TimePeriod()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var focusTarget: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        focusTarget.text = targetString
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        if timerEnable == true{
            stopButton.setTitle("Start", for: .normal)
            timer?.invalidate()
            totalTime.minutes += passedTime.minutes
            totalTime.seconds += passedTime.seconds
            print("passed time: \(passedTime.minutes) : \(passedTime.seconds)")
            print("total time : \(totalTime.minutes) : \(totalTime.seconds)")
            //store passed time and restart a date
            
            timerEnable = false
        }else{
            stopButton.setTitle("Stop", for: .normal)
            clickedDate = Date()
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
            timerEnable = true
        }
    }
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @objc func updateUI() {
        let rightNow = Date()
        if let dateFrom = clickedDate{
            let timePeriod = calendar.dateComponents([.minute,.second], from: dateFrom, to: rightNow)
            if let minute = timePeriod.minute, let second = timePeriod.second{
                timeLabel.text = String(format: "%02d : %02d", minute+totalTime.minutes, second+totalTime.seconds)
                print(timeLabel.text!)
                //print("Focus Scene: \(timePeriod.minute) : \(timePeriod.second)")
                passedTime.minutes = minute
                passedTime.seconds = second
            }
        }
    }
    func storePassedTime(){
        
    }


}
