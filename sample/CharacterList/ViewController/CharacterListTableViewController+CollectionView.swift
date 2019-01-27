//
//  CharacterListTableViewController+CollectionView.swift
//  SimpsonsCharacterViewer
//
//  Created by ᗧ•• Lee on 1/27/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import Foundation
import UIKit


// MARK: - UICollectionViewDataSource

extension CharacterListTableViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionCell", for: indexPath) as! CharacterCollectionViewCell
        
        let imageView :  UIImageView = UIImageView(frame: .zero);
        imageView.contentMode = .scaleAspectFit
        
        if let viewModel = viewModel {
            
            let characterModel = viewModel.characterData[indexPath.item]
            
            if characterModel.image == nil {
                
                if let  img  =  UIImage(named:"imagePlaceholder"){
                    
                    imageView.image = img
                    
                }else{
                    fatalError("no placeholder image for collection cell")
                }
                
                let imageUrl = viewModel.imageUrl(for: indexPath.item)
                
                dataManager.characterImage (with : imageUrl ){ image, error in
                    
                    if let image = image {
                        
                        DispatchQueue.main.async {
                            imageView.image = image
                            self.updateImage(sender: self,image: image,for: indexPath.item)
                            
                        }
                    }else{
                        
                        // error handling
                    }
                    
                }
                
                
            }else{
                
                imageView.image = characterModel.image
                
            }
        }
        cell.contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        cell.contentView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true;
        cell.contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true;
        cell.contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0).isActive = true;
        cell.contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0).isActive = true;
        
        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.numberOfCharacters
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("User tapped on item \(indexPath.row)")
        
        let viewController:CharacterDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        
        guard let characterData = self.viewModel?.characterData[indexPath.item] else{ return }
        viewController.viewModel = CharacterDetailViewModel(characterDetailData :characterData)
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
