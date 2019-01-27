//
//  CharacterCollectionViewCell.swift
//  sample
//
//  Created by ᗧ•• Lee on 1/26/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CharacterCollectionCell"
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse(){
        
        for sv in self.contentView.subviews{
            
            sv.removeFromSuperview();
        }
        
    }
    
}
