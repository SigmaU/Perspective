//
//  UITextField+DatePicker.swift
//  Perspective
//
//  Created by Csaba Kuti on 20/09/2021.
//

import UIKit

extension UITextField {

    func setDatePickerAsInputViewFor(target: Any, selectedDate: Date?, color: UIColor) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 200.0))
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.datePickerMode = .date
        datePicker.date = selectedDate ?? Date()
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 40.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(self.didSelectedDate))
        cancel.tintColor = color
        done.tintColor = color
        toolBar.setItems([cancel, flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc private func didSelectedDate() {
        if let datePicker = self.inputView as? UIDatePicker {
            self.text = dateFormatter().string(from: datePicker.date)
        }
    }
    
    @objc func didCancel() {
        self.resignFirstResponder()
    }
}
