//
//  DataManager.swift
//  sample
//
//  Created by ᗧ•• Lee on 1/24/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import Foundation
 import Alamofire

 

final class DataManager {
    
    typealias CharacterDataCompletion = ([CharacterData]?, Error?) -> ()
    
    // MARK: - Properties
    
    private let baseURL: URL
    
    // MARK: - Initialization
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
   
    
//     MARK: - Requesting Data
    func characterData( completion: @escaping CharacterDataCompletion){

        let URL = baseURL
 
        Alamofire.request(URL).responseJSON { response   in

            switch(response.result){

            case .success :
                if let result = response.result.value, let JSON = result as? NSDictionary  {
                    if let relatedTopic = JSON["RelatedTopics"] as? [[String:Any]]{
                     
                        let characterData = relatedTopic.enumerated().map({ (index : Int, dic : Dictionary) -> CharacterData    in
                            
                        var description = ""
                        var title = ""
                        
                        if let descriptionElement = dic["Text"] as? String{
                           
                            let elementArray = descriptionElement.components(separatedBy: " - ")
                           
                            if(elementArray.count > 0){
                                title = elementArray[0];
                            }
                            
                            if(elementArray.count > 1){
                                description = elementArray[1];
                            }
                           
                            
                        }
                        
                        let iconDic = dic["Icon"] as? [String:Any]
                        let imageUrl : String? = iconDic?["URL"]  as? String
                        
                        let characterData = CharacterData(title : title, description : description, imageUrl : imageUrl, image: nil, index : index)
                        
                        return characterData
                        
                    })
                        
                        completion(characterData, nil)
                        print(characterData)
                    }
                }


            case .failure  :
                print(response)
                completion(nil, response.error)
             
            }
        }
    }

    
    func characterImage (with urlString : String , completion : @escaping  ( UIImage? ,Error? ) -> Void) {
    
        Alamofire.request(urlString, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                
                if let imageData = responseData.data, let image = UIImage(data: imageData){
                   
                    completion(image,nil)
                }else{
                    // error handling
                }
   
            })
    }
 
}
