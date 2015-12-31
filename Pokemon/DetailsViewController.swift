//
//  DetailsViewController.swift
//  Pokemon
//
//  Created by Deepthi Kaligi on 30/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var mainImg:UIImageView!
    @IBOutlet weak var descriptionlbl :UILabel!
    @IBOutlet weak var defencelbl : UILabel!
    @IBOutlet weak var weightlbl : UILabel!
    @IBOutlet weak var  pokedexIdlbl :UILabel!
    @IBOutlet weak var heightlbl : UILabel!
    @IBOutlet weak var baseAttacklbl : UILabel!
    @IBOutlet weak var evolbl : UILabel!
    @IBOutlet weak var currentEvoImg : UIImageView!
    @IBOutlet weak var nextEvoImg : UIImageView!
    
    var pokemon : Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
      label.text = pokemon.name
      mainImg.image = UIImage(named: "\(pokemon.id)")
      currentEvoImg.image = UIImage(named: "\(pokemon.id)")
    pokemon.downloadPokemonDetails { () -> () in
        self.heightlbl.text = self.pokemon.ht
        self.weightlbl.text = self.pokemon.wt
        self.descriptionlbl.text = self.pokemon.descp
        self.defencelbl.text = self.pokemon.defence
        self.baseAttacklbl.text = self.pokemon.baseAttack
        self.pokedexIdlbl.text = self.pokemon.id
        self.nextEvoImg.image = UIImage(named: self.pokemon.nextEvolutionId)
        
        }

    }

      

}
