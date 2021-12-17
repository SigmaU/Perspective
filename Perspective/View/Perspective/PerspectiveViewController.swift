//
//  PerspectiveViewController.swift
//  Perspective
//
//  Created by Csaba Kuti on 15/04/2021.
//

import UIKit
import CoreData
import SwipeCellKit
import Charts

final class PerspectiveViewController: UICollectionViewController, SwipeCollectionViewCellDelegate, UIPickerViewAccessibilityDelegate, UIPickerViewDataSource {
    
    lazy var appDelegate = AppDelegate.shared
    lazy var dataStorage = appDelegate.dataStorage
    lazy var managedContext = dataStorage.viewContext
    
    var selectedFolderID = NSManagedObjectID()
    var editedPerspective: Perspective!
    
    var predicate: NSPredicate? = nil
    
    var customPickerView = UIView()
    var chartPickerView: UIPickerView!
    
    lazy var fetchResultsController: NSFetchedResultsController<Perspective> = {
        return dataStorage.fetchResultsController(Perspective.self,
                                                  sortDescriptor: [NSSortDescriptor(key: "timeStamp", ascending: false)],
                                                  delegate: self)
    }()
    
    var allChartTypes: [String] = ["Time Series", "Contingency", "Habit", "Sequential"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addPerspective = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.promptToAddPerspective))
        addPerspective.tintColor = PerspectiveBlue().center
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [spacer, spacer, addPerspective]
        navigationController?.isToolbarHidden = false
        
        let screenWidth = UIScreen.main.bounds.width
        customPickerView = UIView(frame: CGRect(x: 0.0, y: 100.0, width: screenWidth, height: 200.0))
        createPickerView(width: screenWidth)
        //
        predicate = NSPredicate(format: "containedIn = %@", selectedFolderID)
        fetchResultsController.fetchRequest.predicate = predicate
        try? fetchResultsController.performFetch()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = PerspectiveBlue().center
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerspectiveCell", for: indexPath) as! PerspectiveViewCell
        
        cell.delegate = self
        let perspective = fetchResultsController.object(at: indexPath)
        
        cell.name.text = perspective.name
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let perspective = fetchResultsController.object(at: indexPath)
        let perspectiveName = perspective.name
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PerspectiveDetailedViewController") as? PerspectiveDetailedViewController {
            vc.title = perspectiveName
            vc.perspective = perspective
                
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allChartTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allChartTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont(name: "Menlo Regular 11", size: 27)
        label.text = allChartTypes[row]
        label.textAlignment = .center
        return label
    }
    
    private func createPickerView(width: CGFloat) {
        let chartPickerViewFrame: CGRect = CGRect(x: 0, y: 0, width: width, height: 200)

        chartPickerView = UIPickerView(frame: chartPickerViewFrame)
        chartPickerView.delegate = self
        chartPickerView.dataSource = self

        self.customPickerView.addSubview(chartPickerView)
    }
    
    weak var actionToEnable : UIAlertAction?

    @objc func textFieldDidChange(_ textField: UITextField) {
        let isToLong = textField.text!.count >= 28
        let isEmpty = textField.text!.isEmpty
        self.actionToEnable?.isEnabled = !isEmpty && !isToLong ? true : false
    }
    
    @objc private func promptToAddPerspective() {
        let ac = UIAlertController(title: "Create Perspective", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "Perspective Name:"
            textField.autocapitalizationType = .sentences
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "Select Chart Type"
            textField.autocapitalizationType = .sentences
            if textField.text!.isEmpty {
                textField.text = self.allChartTypes[0]
            }
            textField.setChartPickerAsInputViewFor(target: self, customView: self.customPickerView)
        }
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "Y Axis Title:"
            textField.autocapitalizationType = .sentences
        }
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "X Axis Title:"
            textField.autocapitalizationType = .sentences
        }
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "Y Axis Unit:"
        }
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "X Axis Unit:"
        }
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "Horizontal Line:"
        }
        ac.addTextField { (textField) -> Void in
            textField.placeholder = "Vertical Line:"
        }
        
        
        let submitAction = UIAlertAction(title: "Create", style: .default) { [weak self, weak ac] action in
            guard let perspectiveName = ac?.textFields?[0].text else { return }
            guard let chartType = ac?.textFields?[1].text else { return }
            guard let yAxisName = ac?.textFields?[2].text else { return }
            guard let xAxisName = ac?.textFields?[3].text else { return }
            guard let yAxisUnit = ac?.textFields?[4].text else { return }
            guard let xAxisUnit = ac?.textFields?[5].text else { return }
            guard let horizontalLine = ac?.textFields?[6].text else { return }
            guard let verticalLine = ac?.textFields?[7].text else { return }
            
            self?.submit(perspectiveName: perspectiveName, chartType: chartType, xAxisName: xAxisName, yAxisName: yAxisName, xAxisUnit: xAxisUnit, yAxisUnit: yAxisUnit, horizontalLine: horizontalLine, verticalLine: verticalLine)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            return
        }
        
        ac.view.tintColor = PerspectiveBlue().center
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        
        self.actionToEnable = submitAction
        submitAction.isEnabled = false
        present(ac, animated: true)
    }
    
    private func submit(perspectiveName: String, chartType: String, xAxisName: String, yAxisName: String, xAxisUnit: String, yAxisUnit: String, horizontalLine: String, verticalLine: String) {
        let perspective = Perspective(context: managedContext)
        perspective.timeStamp = Date()
        perspective.name = perspectiveName
        perspective.type = chartType
        perspective.yAxisName = yAxisName.isEmpty ? "y" : yAxisName
        perspective.xAxisName = xAxisName.isEmpty ? "x" : xAxisName
        perspective.yAxisUnit = yAxisUnit
        perspective.xAxisUnit = xAxisUnit
        perspective.horizontalLine = Double(horizontalLine.doubleValue ?? 0.0)
        perspective.verticalLine = Double(verticalLine.doubleValue ?? 0.0)
        
        do {
            let selectedFolder = try managedContext.existingObject(with: selectedFolderID) as? Folder
            perspective.containedIn = selectedFolder
            
        } catch {
            print("error while adding specific folder to perspective contained relationship")
        }
        
        dataStorage.addData(for: perspective)
        collectionView.reloadData()
    }
}

extension PerspectiveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 44)
    }
}

extension PerspectiveViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}
