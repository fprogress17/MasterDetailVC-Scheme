//
//  CharacterViewModel.swift
//  sample
//
//  Created by ᗧ•• Lee on 1/24/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import Foundation


struct CharacterListViewModel{
    
    //let characterData : [[String:String?]]
    var characterData : [CharacterData]
  
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfCharacters : Int{
        return characterData.count
    }
    
    func title(for index: Int) -> String {
        
        return characterData[index].title ?? ""
        
    }
    
    func description(for index: Int) -> String {
        
           return characterData[index].description ?? ""
        
    }
    
    func imageUrl(for index : Int)->String{
        
          return characterData[index].imageUrl ?? ""
        
    }
    
//    func title(for index: Int) -> String {
//
//        let charData = characterData[index]
//
//        var title = ""
//        if let text = charData["text"], let arr = text?.components(separatedBy: " - "){
//            title = arr[0];
//        }
//
//        return title;
//
//    }
//
//    func description(for index: Int) -> String {
//
//        let charData = characterData[index]
//
//        var description = ""
//        if let text = charData["text"], let arr = text?.components(separatedBy: " - "){
//            description = arr[1];
//        }
//
//        return description;
//
//    }
//
//    func imageUrl(for index : Int)->String{
//
//        let charData = characterData[index]
//
//        let imageUrl = ""
//        if let url = charData["imageUrl"] {
//            return url!
//        }
//
//        return imageUrl;
//
//    }

    
}
