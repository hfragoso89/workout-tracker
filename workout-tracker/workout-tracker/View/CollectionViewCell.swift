//
//  CollectionViewCell.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/27/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class CollectionViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }

//    MARK: - CollectionViewDataSource Methods
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoutineCollectionViewCell", for: indexPath) as? RoutineCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
