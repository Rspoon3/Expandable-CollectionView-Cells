//
//  ViewController.swift
//  Expandable CollectionView Cells
//
//  Created by Richard Witherspoon on 3/26/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CustomCellProtocol {
   
    //MARK: ivars
    let customCell = CustomCell()
    var teams = ["Steelers", "49ers", "Colts", "Patriots", "Rams", "Falcons", "Eagels", "Cowboys,", "Raiders", "Bears", "Giants"]

    //MARK: view functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Football Teams"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: customCell.cellID)
        collectionView.delegate = self
        collectionView.backgroundColor = .backgroundGray
    }

    //MARK: collectionView functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCell.cellID, for: indexPath) as! CustomCell
        cell.title.text = teams[indexPath.item]
        cell.number.text = "\(indexPath.item)"
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.performBatchUpdates(nil, completion: nil)
    }

    //MARK: CollectionView Layout Functions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = view.frame.width * 0.05
        let width  : CGFloat = collectionView.frame.width - 2 * padding
        var height : CGFloat = customCell.originalCellHeight
        
        collectionView.contentInset.left = padding
        collectionView.contentInset.right = padding
        
        switch collectionView.indexPathsForSelectedItems?.first {
        case .some(indexPath):
            animateDropMenu(collectionView: collectionView, height: &height)
        default:
            height = customCell.originalCellHeight
        }
        
        return CGSize(width: width, height: height)
    }
    
    //MARK: Private helper functions
    fileprivate func animateDropMenu(collectionView: UICollectionView, height: inout CGFloat) {
        let myIndexPath = collectionView.indexPathsForSelectedItems
        let cell = collectionView.cellForItem(at: myIndexPath!.first!) as! CustomCell
    
        if cell.frame.height == cell.originalCellHeight{
            let titleOGHeight = cell.title.frame.height
            let constraints = [cell.titleTop, cell.titleBottom, cell.buttonsStackHeight]
            let buttonHeight = cell.originalCellHeight / 2
            let stackSpacing : CGFloat = 25
            
            NSLayoutConstraint.deactivate(constraints)
            cell.buttonsStackView.isHidden = false
            cell.buttonsStackView.spacing = stackSpacing
            cell.titleTop = cell.title.topAnchor.constraint(equalTo: cell.topAnchor)
            cell.titleHeight = cell.title.heightAnchor.constraint(equalToConstant: titleOGHeight)
            cell.buttonsStackHeight = cell.deleteButton.heightAnchor.constraint(equalToConstant: buttonHeight)
            
            let newConstraints = [cell.titleTop, cell.titleHeight, cell.buttonsStackHeight]
            NSLayoutConstraint.activate(newConstraints)
            height = cell.originalCellHeight + buttonHeight * 2 + stackSpacing * 2
        } else {
            height = cell.originalCellHeight
        }
    }
    
    //MARK: CustomCellProtocol functions
    func deleteCell(indexPath: IndexPath) {
        
        collectionView.performBatchUpdates({
            teams.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
        }) { (finished) in
            self.collectionView.reloadData()
        }

    }
    
    func shrinkCell() {
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}


