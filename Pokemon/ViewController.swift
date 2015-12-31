//
//  ViewController.swift
//  Pokemon
//
//  Created by Deepthi Kaligi on 27/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    // outlets
    @IBOutlet weak var collectionView :UICollectionView!
    @IBOutlet weak var searchBar : UISearchBar!
   // local varibles
    var isAudioOn = true
    var player : AVAudioPlayer!
    var pokemon:[Pokemon] = []
    var inSearchMode = false
    var filteredPokemon:[Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationItem.rightBarButtonItem?.title = "PAUSE"
    searchBar.returnKeyType = .Done
    searchBar.delegate = self
  //  navigationController?.navigationBarHidden = true
    // play the back music
   // initAudio()
   // getting the pokemon details fron csv
    parsePokemonCSV()
  
}
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
   
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var poke : Pokemon!
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }

        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cells", forIndexPath: indexPath) as? CollectionViewCell {
    
       cell.configureCell(poke)
       return cell
        }
        let cell = CollectionViewCell()
        cell.configureCell(poke)
        return cell
 }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !inSearchMode {
            return pokemon.count
        } else {
            return filteredPokemon.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105.0, 105.0)
    }
  
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        let url = NSURL(string: path!)
        do {
            player = try  AVAudioPlayer(contentsOfURL:url!)
        } catch let error as NSError {
            print("error occurd \(error)")
        }
        player.prepareToPlay()
        player.numberOfLoops = 3
        player.play()

    }
   
    @IBAction func pauseAudio(sender: UIBarButtonItem) {
        if isAudioOn {
            player.stop()
            isAudioOn = false
            sender.title = "PLAY"
            
        } else {
            player.play()
            isAudioOn = true
            sender.title = "PAUSE"
        }
    }
    
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            for row in rows {
                let pokeId = row["id"]!
                let name = row["identifier"]!
                let poke = Pokemon(name: name,id : pokeId)
                pokemon.append(poke)
                collectionView.reloadData()
        }
        } catch let error as NSError {
            print("error ocuured \(error.debugDescription)")
        }
}
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text?.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower!) != nil })
            collectionView.reloadData()
       }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "todvc" {
            if let dvc = segue.destinationViewController as? DetailsViewController {
                let index = collectionView.indexPathsForSelectedItems()!
                let entry = index[0]
                
                if !inSearchMode {
                dvc.pokemon = pokemon[entry.row]
                } else {
                   dvc.pokemon = filteredPokemon[entry.row]
                }
            }
        }
    }
    
    
    
    

}