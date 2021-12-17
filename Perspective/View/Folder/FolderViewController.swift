//
//  FolderViewController.swift
//  Perspective
//
//  Created by Csaba Kuti on 15/04/2021.
//

import UIKit
import CoreData
import SwipeCellKit

final class FolderViewController: UICollectionViewController, SwipeCollectionViewCellDelegate {
    
    lazy var appDelegate = AppDelegate.shared
    lazy var dataStorage = appDelegate.dataStorage
    lazy var managedContext = dataStorage.viewContext
    
    var editedFolder: Folder!
    
    var selectedFolderID = NSManagedObjectID()
    var selectedFolder: Folder! {
        self.managedContext.object(with: self.selectedFolderID) as? Folder
    }
    
    lazy var fetchResultsController: NSFetchedResultsController<Folder> = {
        return dataStorage.fetchResultsController(Folder.self,
                                                  sortDescriptor: [NSSortDescriptor(key: "timeStamp", ascending: true)],
                                                  delegate: self)
    }()
    
    lazy var perspectiveFetchResultsController: NSFetchedResultsController<Perspective> = {
        return dataStorage.fetchResultsController(Perspective.self,
                                                  sortDescriptor: [NSSortDescriptor(key: "timeStamp", ascending: false)],
                                                  delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Folders"
        
        var addFolder = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.promptToAddFolder))
        if #available(iOS 13, *) {
            let image = UIImage(systemName: "folder.badge.plus")
            addFolder = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.promptToAddFolder))
        }
        addFolder.tintColor = PerspectiveBlue().center
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [spacer, spacer, addFolder]
        navigationController?.isToolbarHidden = false
        try? fetchResultsController.performFetch()

        
        if appDelegate.isFirstLaunch() {
            let demo = DemoPerspective()
            demo.addData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            navigationController?.toolbar.backgroundColor = .white
            
            self.navigationController?.toolbar.layer.masksToBounds = false
            self.navigationController?.toolbar.layer.shadowColor = UIColor.black.cgColor
            self.navigationController?.toolbar.layer.shadowOpacity = 0.8
            self.navigationController?.toolbar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.navigationController?.toolbar.layer.shadowRadius = 2
            
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        self.navigationController?.navigationBar.tintColor = PerspectiveBlue().center
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FolderCell", for: indexPath) as! FolderViewCell
        cell.delegate = self
        
        let folder = fetchResultsController.object(at: indexPath)
        cell.name.text = folder.name
        cell.layer.cornerRadius = 7
        
        let image = UIImage(named: "chevron_right.png")
        cell.chevron.image = image
        
        let predicate = NSPredicate(format: "containedIn = %@", folder.objectID)
        perspectiveFetchResultsController.fetchRequest.predicate = predicate
        try? perspectiveFetchResultsController.performFetch()
        
        cell.number.text = "\(perspectiveFetchResultsController.sections?[0].numberOfObjects ?? 0)"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let folder = fetchResultsController.object(at: indexPath)
        let folderName = folder.name
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PerspectiveViewController") as? PerspectiveViewController {
            vc.title = folderName
            vc.selectedFolderID = folder.objectID

            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    weak var actionToEnable : UIAlertAction?
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let isToLong = textField.text!.count >= 28
        let isEmpty = textField.text!.isEmpty
        self.actionToEnable?.isEnabled = !isEmpty && !isToLong ? true : false
    }
    
    @objc private func promptToAddFolder()
    {
        let ac = UIAlertController(title: "Add Folder", message: nil, preferredStyle: .alert)

        ac.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = "Folder Name"
            textField.autocapitalizationType = .sentences
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        })

        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let folderName = ac?.textFields?[0].text else { return }
            self?.submitData(itemName: folderName)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            return
        }
        
        ac.view.tintColor = PerspectiveBlue().center
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        self.actionToEnable = submitAction
        submitAction.isEnabled = false
        self.present(ac, animated: true)
    }
    
    private func submitData(itemName: String) {
        let folder = Folder(context: managedContext)
        folder.name = itemName
        folder.timeStamp = Date()
        
        dataStorage.addData(for: folder)
    }
}

extension FolderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 44)
    }
}

extension FolderViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}
