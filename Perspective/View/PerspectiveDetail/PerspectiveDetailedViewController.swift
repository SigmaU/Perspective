//
//  ViewController.swift
//  Perspective
//
//  Created by Csaba Kuti on 14/04/2021.
//

import UIKit
import CoreData

final class PerspectiveDetailedViewController: UIViewController, sharedEditableCollectionViewController {
    
    lazy var appDelegate = AppDelegate.shared
    lazy var dataStorage = appDelegate.dataStorage
    lazy var managedContext = dataStorage.viewContext
    
    var perspective: Perspective!
    
    let toPerspectiveChartView = "ToPerspectiveChartView"
    let toPerspectiveDataView = "ToPerspectiveDataView"
    let perspectiveViewController = "PerspectiveViewController"
    
    var perspectiveDataViewController: PerspectiveDataViewController!
    var perspectiveChartViewController: PerspectiveChartViewController!
    var perspectiveChart: PerspectiveChartType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perspectiveChart = PerspectiveChartType(ChartType(rawValue: perspective.type)!)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPerspective))
        let addData = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.promptToAddPerspectiveData))
        addData.tintColor = perspectiveChart.color.center
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [spacer, spacer, addData]
        navigationController?.isToolbarHidden = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = perspectiveChart.color.center
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toPerspectiveDataView {
            perspectiveDataViewController = segue.destination as? PerspectiveDataViewController
            perspectiveDataViewController.perspectiveID = perspective.objectID
        }
        if segue.identifier == toPerspectiveChartView {
            perspectiveChartViewController = segue.destination as? PerspectiveChartViewController
            perspectiveChartViewController.perspectiveID = perspective.objectID
        }
    }
    
    @objc private func editPerspective() {
        editPerspectiveUIAlert(viewController: self, editedPerspective: perspective, dataStorage: self.dataStorage)

    }
    
    weak var actionToEnable : UIAlertAction?
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let isToLong = textField.text!.count >= 26
        let isEmpty = textField.text!.isEmpty
        self.actionToEnable?.isEnabled = !isEmpty && !isToLong ? true : false
    }
    
    @objc private func promptToAddPerspectiveData() {
        let perspectiveDataName = self.perspective.name + " " + self.perspective.yAxisName
        let ac = UIAlertController(title: "Add \(perspectiveChart.hasDataName ? "Item" : perspectiveDataName)" , message: nil, preferredStyle: .alert)
        if perspectiveChart.hasDataName {
            ac.addTextField { (textField) -> Void in
                textField.placeholder = "Item Name:"
                textField.keyboardType = .default
                textField.autocapitalizationType = .sentences
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            }
        }
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "\(self.perspective.yAxisName):"
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            textField.keyboardType = .decimalPad
        }
        if perspectiveChart.hasDate {
            ac.addTextField { (textField) -> Void in
                textField.placeholder = "Date:"
                if textField.text!.isEmpty {
                    textField.text = dateFormatter().string(from: Date())
                }
                textField.setDatePickerAsInputViewFor(target: self, selectedDate: nil, color: self.perspectiveChart.color.center)
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            }
            
        } else {
            ac.addTextField { (textField) -> Void in
                textField.placeholder = "\(self.perspective.xAxisName):"
                textField.keyboardType = .decimalPad
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            }
        }
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            let i = !self!.perspectiveChart.hasDataName ? 1 : 0
            guard let name = ac?.textFields?[i].text else { return }
            guard let y = ac?.textFields?[1 - i].text else { return }
            guard let x = ac?.textFields?[2 - i].text else { return }

            self?.submit(name: name, x: x, y: y)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            return
        }
        
        ac.view.tintColor = perspectiveChart.color.center
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        self.actionToEnable = submitAction
        
        submitAction.isEnabled = false
        present(ac, animated: true)
    }
    
    private func submit(name: String, x: String, y: String) {
        let perspectiveData = PerspectiveData(context: managedContext)
        perspective.timeStamp = Date()
        perspectiveData.timeStamp = Date()
        perspectiveData.name = name
        
        let x = perspectiveChart.hasDate ? dateFormatter().date(from: x)!.timeIntervalSince1970 : (Double(x) ?? 0.0)
        
        perspectiveData.x = x
        perspectiveData.y = Double(y.doubleValue ?? 0.0)
        
        perspectiveData.belongsTo = perspective
        dataStorage.addData(for: perspectiveData)
    }
    
}
