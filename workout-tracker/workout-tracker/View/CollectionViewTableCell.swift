//
//  CollectionViewCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/27/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class CollectionViewTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var routinesArray: [WorkoutDay]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }

//    MARK: - CollectionViewDataSource Methods
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routinesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoutineCollectionViewCell", for: indexPath) as? RoutineCollectionViewCell {
            cell.setUpUI(withRoutineName: routinesArray[indexPath.row].name, routineDetails: routinesArray[indexPath.row].name, andBackGroundImage: routinesArray[indexPath.row].image ?? UIImage(named: "reach_goal")!)
            //SetTintColor
            //ActivateBookMark if necessary
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
