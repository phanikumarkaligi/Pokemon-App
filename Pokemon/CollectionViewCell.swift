//
//  CollectionViewCell.swift
//  Pokemon
//
//  Created by Deepthi Kaligi on 27/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  // outlets
    @IBOutlet weak var imageView :UIImageView!
    @IBOutlet weak var label : UILabel!
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 2.0
        layer.shadowRadius = 8.0
        layer.shadowColor = UIColor.greenColor().CGColor
        
 }
    
    func configureCell(pokemon:Pokemon) {
        imageView.image = UIImage(named:"\(pokemon.id)")
        label.text = pokemon.name
 }
}
