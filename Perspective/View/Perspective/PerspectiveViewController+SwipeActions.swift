//
//  PerspectiveSwipeActions.swift
//  Perspective
//
//  Created by Csaba Kuti on 12/05/2021.
//

import UIKit
import CoreData
import SwipeCellKit

extension PerspectiveViewController: sharedEditableCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        self.editedPerspective = fetchResultsController.object(at: indexPath)
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.dataStorage.delete(self.editedPerspective)
            action.fulfill(with: .delete)
        }
        
        let editAction = SwipeAction(style: .default, title: "Edit", handler: { action, indexPath in
            self.promptToEditPerspective()
            action.hidesWhenSelected = true
            action.fulfill(with: .reset)
        })
        
        deleteAction.hidesWhenSelected = true
        deleteAction.backgroundColor = PerspectivePurple().center
        editAction.backgroundColor = PerspectiveBlue().center
        
        return [deleteAction, editAction]
    }
    
    @objc private func promptToEditPerspective() {
        
        editPerspectiveUIAlert(viewController: self, editedPerspective: editedPerspective, dataStorage: self.dataStorage)
        
        for cell in collectionView.visibleCells {
            if let cell = cell as? SwipeCollectionViewCell {
                cell.hideSwipe(animated: true)
            }
        }
    }
}
