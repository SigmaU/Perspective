//
//  DataViewController.swift
//  Perspective
//
//  Created by Csaba Kuti on 15/04/2021.
//

import UIKit
import CoreData
import SwipeCellKit

final class PerspectiveDataViewController: UICollectionViewController, SwipeCollectionViewCellDelegate {
    
    lazy var appDelegate = AppDelegate.shared
    lazy var dataStorage = appDelegate.dataStorage
    lazy var managedContext = dataStorage.viewContext
    var perspectiveChartViewController: PerspectiveChartViewController!
    
    var perspectiveID: NSManagedObjectID!
    var perspective: Perspective! {
        self.managedContext.object(with: self.perspectiveID) as? Perspective
    }
    var perspectiveChart: PerspectiveChartType!

    var editedPerspectiveData: PerspectiveData!

    weak var actionToEnable : UIAlertAction?
    
    var predicate: NSPredicate? = nil
    lazy var fetchResultsController: NSFetchedResultsController<PerspectiveData> = {
        let perspectiveDataSortType = PerspectiveChartType.init(ChartType(rawValue: perspective.type)!).sortType
        return dataStorage.fetchResultsController(PerspectiveData.self,
                                                  sortDescriptor: [NSSortDescriptor(key: perspectiveDataSortType, ascending: false)],
                                                  delegate: self)
    }()
    
    let editAc = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perspectiveChart = PerspectiveChartType(ChartType(rawValue: perspective.type)!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataChanged), name: .NSManagedObjectContextObjectsDidChange, object: managedContext)
        
        predicate = NSPredicate(format: "belongsTo = %@", perspectiveID)
        fetchResultsController.fetchRequest.predicate = predicate
        try? fetchResultsController.performFetch()
        
    }
    
    @objc private func dataChanged() {
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: PerspectiveDataViewCell!
        let entry = fetchResultsController.object(at: indexPath)
        
        if perspectiveChart.type == ChartType.contingency.rawValue {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerspectiveDataContingencyCell", for: indexPath) as? PerspectiveDataViewCell
            cell.name.text = entry.name
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerspectiveDataDefaultCell", for: indexPath) as? PerspectiveDataViewCell
        }
        cell.delegate = self
        
        let entryX = perspectiveChart.hasDate ? "\(dateFormatter(style: .full).string(from: Date(timeIntervalSince1970: entry.x)))" : String(entry.x)
        
        cell.layer.cornerRadius = 7
        switch perspectiveChart.type {
        case ChartType.timeSeries.rawValue:
            cell.x.text = entryX
            cell.y.text = "\(entry.y)" + " " + "\(perspective.yAxisUnit)"
            cell.y.textColor = perspectiveChart.color.major
            cell.shape.backgroundColor = UIColor.clear
            cell.shape.frame = CGRect(x: 22.0, y: 18.0, width: 10.0, height: 10.0)
            cell.shape.layer.borderWidth = 2.5
            cell.shape.layer.borderColor = perspectiveChart.color.major.cgColor
            cell.shape.layer.cornerRadius = cell.shape.frame.width / 2
        case ChartType.habit.rawValue:
            cell.x.text = entryX
            cell.y.text = "\(entry.y)" + " " + "\(perspective.yAxisUnit)"
            cell.y.textColor = perspectiveChart.color.major
            cell.shape.backgroundColor = perspectiveChart.color.major
            cell.shape.frame = CGRect(x: 20.5, y: 16.5, width: 13.5, height: 13.5)
            cell.shape.layer.borderWidth = 2.5
            cell.shape.layer.borderColor = perspectiveChart.color.gray.cgColor
        case ChartType.contingency.rawValue:
            cell.x.text = "\(perspective.xAxisName)" + ": " + entryX + " " + perspective.xAxisUnit
            cell.y.text = "\(perspective.yAxisName)" + ": " + "\(entry.y)" + " " + perspective.yAxisUnit
            cell.name.textColor = perspectiveChart.color.major
            cell.shape.backgroundColor = perspectiveChart.color.major
            cell.shape.frame = CGRect(x: 20.5, y: 16.5, width: 13.5, height: 13.5)
            cell.shape.layer.borderWidth = 2.5
            cell.shape.layer.borderColor = perspectiveChart.color.gray.cgColor
            cell.shape.layer.cornerRadius = cell.shape.frame.width / 2
        default:
            cell.x.text = "\(perspective.xAxisName)" + ": " + entryX + " " + perspective.xAxisUnit
            cell.y.text = "\(perspective.yAxisName)" + ": " + "\(entry.y)" + " " + perspective.yAxisUnit
            cell.y.textColor = perspectiveChart.color.black
            cell.shape.backgroundColor = perspectiveChart.color.black
            cell.shape.frame = CGRect(x: 20.5, y: 16.5, width: 13.5, height: 13.5)
            cell.shape.layer.borderWidth = 2.5
            cell.shape.layer.borderColor = perspectiveChart.color.gray.cgColor
            cell.shape.layer.cornerRadius = cell.shape.frame.width / 2
        }
        
        return cell
    }
}

extension PerspectiveDataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 44)
    }
}

extension PerspectiveDataViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}
