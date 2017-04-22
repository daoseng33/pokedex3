//
//  Pokemon.swift
//  pokedex
//
//  Created by Ray on 2017/4/5.
//  Copyright © 2017年 Ray. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _attack: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    
    var description: String {
        
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    
    var nextEvolutionText: String {
        
        if _nextEvolutionText == nil {
           _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        // Pokemon api URL
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    // Trun integer to string
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                // 最後可以使用,來確認這個array的count大於0
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for i in 1 ..< types.count {
                            
                            if let name = types[i]["name"] {
                                
                               self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                } else { // there has no type data
                    self._type = "Unknown type"
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        print("descURL: \(descURL)")
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    // 替換字串中的某個單字
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    print(newDescription)
                                    
                                    self._description = newDescription
                                }
                            } else {
                                self._description = ""
                            }
                            
                            completed()
                        })
                    }
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        // mega = 最大進化
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                                
                            }
                            
                            if let levelExist = evolutions[0]["level"] as? Int {
                                
                                self._nextEvolutionLevel = "\(levelExist)"
                                
                            } else {
                                
                                self._nextEvolutionLevel = ""
                            }
                        }
                    }
                }
            }
        }
    }
}
