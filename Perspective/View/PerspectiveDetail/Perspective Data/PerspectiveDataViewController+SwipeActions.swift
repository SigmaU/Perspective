//
//  PerspectiveDataSwipeActions.swift
//  Perspective
//
//  Created by Csaba Kuti on 13/05/2021.
//

import UIKit
import CoreData
import SwipeCellKit

extension PerspectiveDataViewController {

    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {

        self.editedPerspectiveData = fetchResultsController.object(at: indexPath)

        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.dataStorage.delete(self.editedPerspectiveData)
            self.perspective.timeStamp = Date()
            action.fulfill(with: .delete)
        }

        let editAction = SwipeAction(style: .default, title: "Edit", handler: { action, indexPath in
            self.promptToEditPerspectiveData()
            action.hidesWhenSelected = true
            action.fulfill(with: .reset)
        })
        
        deleteAction.hidesWhenSelected = true
        deleteAction.backgroundColor = PerspectivePurple().center
        editAction.backgroundColor = PerspectiveBlue().center

        return [deleteAction, editAction]
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isToLong = textField.text!.count >= 26
        let isEmpty = textField.text!.isEmpty
        self.actionToEnable?.isEnabled = !isEmpty && !isToLong ? true : false
    }
    
    @objc private func promptToEditPerspectiveData() {
        let ac = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
        if perspectiveChart.hasDataName {
            ac.addTextField { (textField) -> Void in
                textField.placeholder = "Item Name:"
                textField.text = self.editedPerspectiveData.name
                textField.autocapitalizationType = .sentences
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
                textField.keyboardType = .default
            }
        }
        ac.addTextField { (textField) -> Void in
            textField.text = "\(self.editedPerspectiveData.y)"
            textField.placeholder = "\(self.perspective.yAxisName):"
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            textField.keyboardType = .decimalPad
        }
        if perspectiveChart.hasDate {
            ac.addTextField { (textField) -> Void in
                textField.placeholder = "Date:"
                textField.text = "\(dateFormatter().string(from: Date(timeIntervalSince1970: self.editedPerspectiveData.x)))"
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .touchDown)
                textField.setDatePickerAsInputViewFor(target: self, selectedDate: Date(timeIntervalSince1970: self.editedPerspectiveData.x), color: self.perspectiveChart.color.center)
                
            }
        } else {
            ac.addTextField { (textField) -> Void in
                textField.placeholder = "\(self.perspective.xAxisName):"
                textField.text = "\(self.editedPerspectiveData.x)"
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
                textField.keyboardType = .decimalPad
            }
        }
        
        
        let submitAction = UIAlertAction(title: "Done", style: .default) { [weak self, weak ac] action in
            let i = !self!.perspectiveChart.hasDataName ? 1 : 0
            guard let name = ac?.textFields?[i].text else { return }
            guard let y = ac?.textFields?[1 - i].text else { return }
            guard let x = ac?.textFields?[2 - i].text else { return }
            
            self?.submitEdit(name: name, x: x, y: y)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            return
        }
        
        perspective.timeStamp = Date()
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        ac.view.tintColor = perspectiveChart.color.major
        present(ac, animated: true)
        self.actionToEnable = submitAction
        submitAction.isEnabled = false
        
        for cell in collectionView.visibleCells {
            if let cell = cell as? SwipeCollectionViewCell {
                cell.hideSwipe(animated: true)
            }
        }
    }

    private func submitEdit(name: String, x: String, y: String) {
        editedPerspectiveData.name = name
        
        let x = perspectiveChart.hasDate ? dateFormatter().date(from: x)!.timeIntervalSince1970 : (Double(x) ?? 0.0)
        
        editedPerspectiveData.x = x
        editedPerspectiveData.y = Double(y.doubleValue ?? 0.0)
        dataStorage.saveContext()
        
    }

}
