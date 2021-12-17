//
//  UITextField+ChartPicker.swift
//  Perspective
//
//  Created by Csaba Kuti on 06/10/2021.
//

import UIKit

extension UITextField {

    func setChartPickerAsInputViewFor(target: Any, customView: UIView) {
        
        let screenWidth = UIScreen.main.bounds.width
        self.inputView = customView
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 40.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(self.didSelectedChart))
        toolBar.setItems([cancel, flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc private func didSelectedChart() {
        if let chartPickerView = self.inputView?.subviews[0] as? UIPickerView {
            let component = 0
            let row = chartPickerView.selectedRow(inComponent: component)
            self.text = chartPickerView.delegate?.pickerView?(chartPickerView, titleForRow: row, forComponent: component)
        }
    }
    
}
