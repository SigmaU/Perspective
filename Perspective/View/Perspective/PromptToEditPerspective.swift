//
//  PromptToEditPerspective.swift
//  Perspective
//
//  Created by Csaba Kuti on 28/10/2021.
//

import Foundation
import UIKit

@objc protocol UITextFieldReporter {
    var actionToEnable : UIAlertAction? { get set }
    @objc func textFieldDidChange(_ textField: UITextField)
}

protocol sharedEditableCollectionViewController: UIViewController, UITextFieldReporter {
    var dataStorage: DataStorageProvider { get set }
    
}

func editPerspectiveUIAlert(viewController: sharedEditableCollectionViewController, editedPerspective: Perspective, dataStorage: DataStorageProvider) {
    let perspectiveChart = PerspectiveChartType(ChartType(rawValue: editedPerspective.type)!)
    let ac = UIAlertController(title: "Edit Perspective", message: nil, preferredStyle: .alert)
    ac.addTextField { (textField) -> Void in
        textField.placeholder = "Perspective Name:"
        textField.text = editedPerspective.name
        textField.autocapitalizationType = .sentences
        textField.keyboardType = .default
        textField.addTarget(viewController, action: #selector(viewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    ac.addTextField { (textField) -> Void in
        textField.placeholder = "Y Axis Title:"
        textField.text = editedPerspective.yAxisName
        textField.autocapitalizationType = .sentences
    }
    ac.addTextField { (textField) -> Void in
        textField.placeholder = "X Axis Title:"
        textField.text = editedPerspective.xAxisName
        textField.autocapitalizationType = .sentences
    }
    ac.addTextField { (textField) -> Void in
        textField.placeholder = "Y Axis Unit:"
        textField.text = editedPerspective.yAxisUnit
    }
    ac.addTextField { (textField) -> Void in
        textField.placeholder = "X Axis Unit:"
        textField.text = editedPerspective.xAxisUnit
    }
    ac.addTextField { (textField) -> Void in
        textField.placeholder = "Horizontal Line:"
        textField.keyboardType = .decimalPad
        textField.text = "\(editedPerspective.horizontalLine)"
    }
    ac.addTextField { (textField) -> Void in
        textField.placeholder = "Vertical Line:"
        textField.keyboardType = .decimalPad
        textField.text = "\(editedPerspective.verticalLine)"
    }
    
    let submitAction = UIAlertAction(title: "Done", style: .default) { [weak ac] action in
        guard let perspectiveName = ac?.textFields?[0].text else { return }
        guard let yAxisName = ac?.textFields?[1].text else { return }
        guard let xAxisName = ac?.textFields?[2].text else { return }
        guard let yAxisUnit = ac?.textFields?[3].text else { return }
        guard let xAxisUnit = ac?.textFields?[4].text else { return }
        guard let horizontalLine = ac?.textFields?[5].text else { return }
        guard let verticalLine = ac?.textFields?[6].text else { return }

        
        submitEdit(editedPerspective: editedPerspective, perspectiveName: perspectiveName, xAxisName: xAxisName, yAxisName: yAxisName, xAxisUnit: xAxisUnit, yAxisUnit: yAxisUnit, horizontalLine: horizontalLine, verticalLine: verticalLine)
        
        viewController.dataStorage.saveContext()
        
        guard let vcStack = viewController.navigationController?.viewControllers else { return }
        let isPerspectiveDetailedViewControllerActive = vcStack.count > 2
        if isPerspectiveDetailedViewControllerActive {
            if let perspectiveDetailedViewController = vcStack[2] as? PerspectiveDetailedViewController {
                perspectiveDetailedViewController.title = perspectiveName
            }
        }
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
        return
    }
    
    ac.view.tintColor = perspectiveChart.color.center
    ac.addAction(submitAction)
    ac.addAction(cancelAction)
    viewController.present(ac, animated: true)
    
    viewController.actionToEnable = submitAction
}

private func submitEdit(editedPerspective: Perspective, perspectiveName: String, xAxisName: String, yAxisName: String, xAxisUnit: String, yAxisUnit: String, horizontalLine: String, verticalLine: String) {
    editedPerspective.name = perspectiveName
    editedPerspective.xAxisName = xAxisName
    editedPerspective.yAxisName = yAxisName
    editedPerspective.xAxisUnit = xAxisUnit
    editedPerspective.yAxisUnit = yAxisUnit
    editedPerspective.horizontalLine = Double(horizontalLine.doubleValue ?? 0.0)
    editedPerspective.verticalLine = Double(verticalLine.doubleValue ?? 0.0)
    
}
