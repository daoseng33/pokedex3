//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Ray on 2017/4/8.
//  Copyright © 2017年 Ray. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var currentEvolutionImageView: UIImageView!
    @IBOutlet weak var nextEvolutionImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainImageView.image = UIImage(named: "\(pokemon.pokedexId)")
        nameLabel.text = pokemon.name.capitalized
        pokedexLabel.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetail {
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        descriptionLabel.text = pokemon.description
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        
        if pokemon.nextEvolutionId.characters.count == 0 {
            
            evolutionLabel.text = "No Evolutions"
            nextEvolutionImageView.isHidden = true
        } else {
            
            evolutionLabel.text = "Next Evolution: \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLevel)"
            nextEvolutionImageView.isHidden = false
        }
        
        nextEvolutionImageView.image = UIImage(named: "\(pokemon.nextEvolutionId)")
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
