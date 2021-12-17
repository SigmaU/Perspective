//
//  DemoPerspective.swift
//  Perspective
//
//  Created by Csaba on 23.11.2021.
//

import Foundation
import CoreData

final class DemoPerspective {
    
    lazy var dataStorage = AppDelegate.shared.dataStorage
    lazy var managedContext = dataStorage.viewContext
    
    var perspectiveChart: PerspectiveChartType!
    
    init() {
    }
    
    func printJSON(model: _Model) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let jsonData = try! jsonEncoder.encode(model)
        let json = String(data: jsonData, encoding: .ascii)
        
        print("JSON string = \n \(json!)")
    }
    
    func addData() {
        for selectedFolder in demoModel.folders {
            let folder = Folder(context: managedContext)
            folder.name = selectedFolder.name
            folder.timeStamp = Date()

            dataStorage.addData(for: folder)
            
            
            for selectedPerspective in selectedFolder.perspectives {
                let perspective = Perspective(context: managedContext)
                perspective.timeStamp = Date()
                perspective.name = selectedPerspective.properties.name
                perspective.type = selectedPerspective.properties.type
                perspective.yAxisName = selectedPerspective.properties.yAxisName
                perspective.xAxisName = selectedPerspective.properties.xAxisName
                perspective.yAxisUnit = selectedPerspective.properties.yAxisUnit
                perspective.xAxisUnit = selectedPerspective.properties.xAxisUnit
                perspective.horizontalLine = Double(selectedPerspective.properties.horizontalLine.doubleValue ?? 0.0)
                perspective.verticalLine =  Double(selectedPerspective.properties.verticalLine.doubleValue ?? 0.0)
                
                do {
                    let selectedFolder = try managedContext.existingObject(with: folder.objectID) as? Folder
                    perspective.containedIn = selectedFolder
                    
                } catch {
                    print("error while adding specific folder to perspective contained relationship")
                }
                
                perspectiveChart = PerspectiveChartType(ChartType(rawValue: perspective.type)!)
                dataStorage.addData(for: perspective)
                
                
                for selectedPerspectiveData in selectedPerspective.dataSeries {
                    let perspectiveData = PerspectiveData(context: managedContext)
                    perspective.timeStamp = Date()
                    perspectiveData.timeStamp = Date()
                    perspectiveData.name = selectedPerspectiveData.name
                    perspectiveData.x = Double(selectedPerspectiveData.x.doubleValue ?? 0.0)
                    perspectiveData.y = Double(selectedPerspectiveData.y.doubleValue ?? 0.0)
                    
                    perspectiveData.belongsTo = perspective
                    dataStorage.addData(for: perspectiveData)
                }
            }
        }
    }
    
}
