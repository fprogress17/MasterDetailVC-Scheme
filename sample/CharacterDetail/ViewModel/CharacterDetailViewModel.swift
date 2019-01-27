//
//  CharacterDetailViewModel.swift
//  sample
//
//  Created by ᗧ•• Lee on 1/25/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import Foundation

class CharacterDetailViewModel{
    
  //  let characterDetailData:[String:String?]
      var characterDetailData:CharacterData
    
    
    private lazy var dataManager = {
        
        return DataManager(baseURL: API.BaseURL)
    }()
    
    
    init(characterDetailData : CharacterData){
        
        self.characterDetailData = characterDetailData;
    }
    
    var imageUrl : String? {
        
        return characterDetailData.imageUrl
        
    }
    
 
    var title : String {
        
         return characterDetailData.title ?? ""
    }

     var description :  String {
 
          return characterDetailData.description ?? ""
    }

    
}
