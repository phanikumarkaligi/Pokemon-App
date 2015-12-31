//
//  Pokemon.swift
//  Pokemon
//
//  Created by Deepthi Kaligi on 27/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    private var _name : String!
    private var _id : String!
    private var _descp : String!
    private var _defence : String!
    private var _ht : String!
    private var _wt : String!
    private var _evolution : String!
    private var _bastAttack : String!
    private var _nextEvolutionId : String!
    
    
    var name : String {
        return _name
    }
    
    var id : String {
        return _id
    }
    
    var descp : String {
        return _descp
    }
    
    var defence : String {
        return _defence
    }
    
    var ht : String {
        return _ht
    }
    
    var wt : String {
        return _wt
    }
    
    var evolution :String {
        return _evolution
    }
    
    var baseAttack : String {
        return _bastAttack
    }
    
    var nextEvolutionId : String {
        return _nextEvolutionId
    }
    
    init(name:String,id : String) {
        self._name = name
        self._id = id
    }
    
    func downloadPokemonDetails(completed : DownloadComplete) {
        Alamofire.request(.GET,"\(baseURL!)\(_id)/").response { (req :NSURLRequest?, resp :NSHTTPURLResponse?,data : NSData?, error : NSError?) -> Void in
            let resstr : NSDictionary
            do {
                resstr =  try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0) ) as! NSDictionary
                let k = resstr["attack"] as! Int
                self._bastAttack = "\(k)"
                self._ht = resstr["height"] as? String
                self._wt = resstr["weight"] as? String
                self._id  = String(resstr["pkdx_id"] as! Int)
                self._defence  = String(resstr["defense"] as! Int)
                print(self._ht)
                if let x = resstr["descriptions"] as? [Dictionary<String,String>] where x.count > 0 {
                    if let type = x[0]["resource_uri"]
                    {
                        // print("\(trimmedURl!)\(type)")
                        
                        // code for description
                        Alamofire.request(.GET,"\(trimmedURl!)\(type)").response { (req :NSURLRequest?, resp :NSHTTPURLResponse?,data : NSData?, error : NSError?) -> Void in
                            let descriptionDict : NSDictionary
                            
                            do {
                                descriptionDict =  try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0) ) as! NSDictionary
                                print(descriptionDict)
                                self._descp = descriptionDict["description"] as? String
                                completed()
                            } catch {
                                
                            }
                        }

                    }
                }
                // code for evolutions image
                if let evolutions =  resstr["evolutions"] as? [Dictionary<String,AnyObject>] {
                    let g = evolutions[0]
                    let gg = g["resource_uri"]
                    
                    let formattedStr = gg?.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                    
                    self._nextEvolutionId = formattedStr?.stringByReplacingOccurrencesOfString("/", withString: "")
                    
                    //                    self.nextEvoImg.image = UIImage(named: "\(nextEvoId!)")
                    
                }
                // main catch beginning
            } catch {
                
            }
        }

        
    }
    
    func fetchData() {
        
           }
    
    func fetchDescription(type : String) {
           }

    
}