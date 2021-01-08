//
//  AlarmViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 14/12/2020.
//

import UIKit

class AlarmViewController: UIViewController {
    
    // Picker view for time selection
    @IBOutlet weak var timePickerView: UIDatePicker!
    
    // Outlest for the day buttons
    @IBOutlet weak var mondayButtonOutlet: UIButton!
    @IBOutlet weak var tuesdayButtonOutlet: UIButton!
    @IBOutlet weak var wednesdayButtonOutlet: UIButton!
    @IBOutlet weak var thursdayButtonOutlet: UIButton!
    @IBOutlet weak var fridayButtonOutlet: UIButton!
    @IBOutlet weak var saturdayButtonOutlet: UIButton!
    @IBOutlet weak var sundayButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerView.setValue(#colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), forKeyPath: "textColor")
        timePickerView.addTarget(self, action: #selector(AlarmViewController.handler(sender:)), for: UIControl.Event.valueChanged)
        
        putBordersOnButtons(width: 2, color: #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1))
        
        // Charge saved data
        putButtonsInCorrectState()
        timePickerView.date = setPickerData()
    }
    
    @objc func handler(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.locale = Locale(identifier: "fr_FR")
        sender.datePickerMode = .time

        let date = sender.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        Alarm.alarm.hour = components.hour!
        Alarm.alarm.minutes = components.minute!
    }
    
    // Actions for the day buttons
    @IBAction func mondayButton(_ sender: Any) {
        if Alarm.alarm.notificationMonday {
            Alarm.alarm.notificationMonday = false
        } else {
            Alarm.alarm.notificationMonday = true
        }
        // Change color of activated/disactivated button
        putButtonsInCorrectState()
        // Save in the database
        Alarm.alarm.saveAlarmParameters()
    }
    
    @IBAction func tuesdayButton(_ sender: Any) {
        if Alarm.alarm.notificationTuesday {
            Alarm.alarm.notificationTuesday = false
        } else {
            Alarm.alarm.notificationTuesday = true
        }
        // Change color of activated/disactivated button
        putButtonsInCorrectState()
        // Save in the database
        Alarm.alarm.saveAlarmParameters()
    }
    
    @IBAction func wednesdayButton(_ sender: Any) {
        if Alarm.alarm.notificationWednesday {
            Alarm.alarm.notificationWednesday = false
        } else {
            Alarm.alarm.notificationWednesday = true
        }
        // Change color of activated/disactivated button
        putButtonsInCorrectState()
        // Save in the database
        Alarm.alarm.saveAlarmParameters()
    }
    
    @IBAction func thursdayButton(_ sender: Any) {
        if Alarm.alarm.notificationThursday {
            Alarm.alarm.notificationThursday = false
        } else {
            Alarm.alarm.notificationThursday = true
        }
        // Change color of activated/disactivated button
        putButtonsInCorrectState()
        // Save in the database
        Alarm.alarm.saveAlarmParameters()
    }
    
    @IBAction func fridayButton(_ sender: Any) {
        if Alarm.alarm.notificationFriday {
            Alarm.alarm.notificationFriday = false
        } else {
            Alarm.alarm.notificationFriday = true
        }
        // Change color of activated/disactivated button
        putButtonsInCorrectState()
        // Save in the database
        Alarm.alarm.saveAlarmParameters()
    }
    
    @IBAction func saturdayButton(_ sender: Any) {
        if Alarm.alarm.notificationSaturday {
            Alarm.alarm.notificationSaturday = false
        } else {
            Alarm.alarm.notificationSaturday = true
        }
        // Change color of activated/disactivated button
        putButtonsInCorrectState()
        // Save in the database
        Alarm.alarm.saveAlarmParameters()
    }
    
    @IBAction func sundayButton(_ sender: Any) {
        if Alarm.alarm.notificationSunday {
            Alarm.alarm.notificationSunday = false
        } else {
            Alarm.alarm.notificationSunday = true
        }
        // Change color of activated/disactivated button
        putButtonsInCorrectState()
        // Save in the database
        Alarm.alarm.saveAlarmParameters()
    }
    
    // Save parameters
    @IBAction func saveButton(_ sender: Any) {
        Alarm.alarm.setAllAlarms()
        Alarm.alarm.saveAlarmParameters()
    }
    
    // Method to set borders to the buttons
    private func putBordersOnButtons(width: CGFloat, color: CGColor) {
        mondayButtonOutlet.layer.borderWidth = width
        mondayButtonOutlet.layer.borderColor = color
        
        tuesdayButtonOutlet.layer.borderWidth = width
        tuesdayButtonOutlet.layer.borderColor = color
        
        wednesdayButtonOutlet.layer.borderWidth = width
        wednesdayButtonOutlet.layer.borderColor = color
        
        thursdayButtonOutlet.layer.borderWidth = width
        thursdayButtonOutlet.layer.borderColor = color
        
        fridayButtonOutlet.layer.borderWidth = width
        fridayButtonOutlet.layer.borderColor = color
        
        saturdayButtonOutlet.layer.borderWidth = width
        saturdayButtonOutlet.layer.borderColor = color
        
        sundayButtonOutlet.layer.borderWidth = width
        sundayButtonOutlet.layer.borderColor = color
    }
    
   // Method to put the day buttons in correct state
    private func putButtonsInCorrectState() {
        if Alarm.alarm.notificationMonday {
            mondayButtonOutlet.backgroundColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
            mondayButtonOutlet.setTitleColor(#colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1), for: .normal)
        } else {
            mondayButtonOutlet.backgroundColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
            mondayButtonOutlet.setTitleColor(#colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), for: .normal)
        }
        
        if Alarm.alarm.notificationTuesday {
            tuesdayButtonOutlet.backgroundColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
            tuesdayButtonOutlet.setTitleColor(#colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1), for: .normal)
        } else {
            tuesdayButtonOutlet.backgroundColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
            tuesdayButtonOutlet.setTitleColor(#colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), for: .normal)
        }
        
        if Alarm.alarm.notificationWednesday {
            wednesdayButtonOutlet.backgroundColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
            wednesdayButtonOutlet.setTitleColor(#colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1), for: .normal)
        } else {
            wednesdayButtonOutlet.backgroundColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
            wednesdayButtonOutlet.setTitleColor(#colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), for: .normal)
        }
        
        if Alarm.alarm.notificationThursday {
            thursdayButtonOutlet.backgroundColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
            thursdayButtonOutlet.setTitleColor(#colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1), for: .normal)
        } else {
            thursdayButtonOutlet.backgroundColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
            thursdayButtonOutlet.setTitleColor(#colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), for: .normal)
        }
        
        if Alarm.alarm.notificationFriday {
            fridayButtonOutlet.backgroundColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
            fridayButtonOutlet.setTitleColor(#colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1), for: .normal)
        } else {
            fridayButtonOutlet.backgroundColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
            fridayButtonOutlet.setTitleColor(#colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), for: .normal)
        }
        
        if Alarm.alarm.notificationSaturday {
            saturdayButtonOutlet.backgroundColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
            saturdayButtonOutlet.setTitleColor(#colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1), for: .normal)
        } else {
            saturdayButtonOutlet.backgroundColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
            saturdayButtonOutlet.setTitleColor(#colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), for: .normal)
        }
        
        if Alarm.alarm.notificationSunday {
            sundayButtonOutlet.backgroundColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
            sundayButtonOutlet.setTitleColor(#colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1), for: .normal)
        } else {
            sundayButtonOutlet.backgroundColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
            sundayButtonOutlet.setTitleColor(#colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1), for: .normal)
        }
        
    }
    
    // Set the timer with saved data
    private func setPickerData() -> Date {
        var dateComponents = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day], from: Date())
        dateComponents.hour = Alarm.alarm.hour
        dateComponents.minute = Alarm.alarm.minutes
        return Calendar.autoupdatingCurrent.date(from: dateComponents) ?? Date()
    }
    
}
