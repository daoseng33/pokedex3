//
//  PokeCell.swift
//  pokedex
//
//  Created by Ray on 2017/4/5.
//  Copyright © 2017年 Ray. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var pokemon: Pokemon!
    
    // 初始化設定
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
}
