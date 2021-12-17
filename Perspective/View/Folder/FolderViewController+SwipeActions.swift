//
//  FolderSwipeActions.swift
//  Perspective
//
//  Created by Csaba Kuti on 12/05/2021.
//

import UIKit
import CoreData
import SwipeCellKit

extension FolderViewController {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        self.editedFolder = fetchResultsController.object(at: indexPath)
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.dataStorage.delete(self.editedFolder)
            action.fulfill(with: .delete)
        }

        let editAction = SwipeAction(style: .default, title: "Edit", handler: { action, indexPath in
            self.promptToEditFolder()
            action.hidesWhenSelected = true
            action.fulfill(with: .reset)
        })
        
        deleteAction.backgroundColor = PerspectivePurple().center
        editAction.backgroundColor = PerspectiveBlue().center
        
        return [deleteAction, editAction]
    }
    
    @objc private func promptToEditFolder() {
        let ac = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields![0].text = self.editedFolder.name
        ac.textFields![0].autocapitalizationType = .sentences
        ac.textFields![0].addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        let submitAction = UIAlertAction(title: "Done", style: .default) { [weak self, weak ac] action in
            guard let name = ac?.textFields?[0].text else { return }
            self?.submitEdit(name: name)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            return
        }
        
        ac.view.tintColor = PerspectiveBlue().center
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        self.actionToEnable = submitAction
        submitAction.isEnabled = true
        present(ac, animated: true)
        
        for cell in collectionView.visibleCells {
            if let cell = cell as? SwipeCollectionViewCell {
                cell.hideSwipe(animated: true)
            }
        }
    }
    
    private func submitEdit(name: String) {
        editedFolder.name = name
        
        dataStorage.saveContext()
        collectionView.reloadData()
    }
}
