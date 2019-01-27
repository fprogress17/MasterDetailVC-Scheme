//
//  DetailViewController.swift
//  sample
//
//  Created by ᗧ•• Lee on 1/25/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import UIKit


protocol CharacterDetailViewControllerDelegate : AnyObject{
    
    func updateImage(sender : Any, image:UIImage, for index : Int)
    
}


class CharacterDetailViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate : CharacterDetailViewControllerDelegate?
    
    private lazy var dataManager = {
        return DataManager(baseURL: API.BaseURL)
    }()
    
    
    var viewModel: CharacterDetailViewModel?
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
          setupView()
    }
    
    private func setupView() {
        
        if let detailViewModel = self.viewModel, let urlString = detailViewModel.imageUrl {
            
            self.imageView.contentMode = .scaleAspectFit
    
            self.titleLabel.text = detailViewModel.title
            self.textView.text = detailViewModel.description
            self.navigationItem.title = detailViewModel.title
    
            if let image = detailViewModel.characterDetailData.image
            {
                self.imageView.image = image;
                
            }else{
                
                self.imageView.image = UIImage(named: "imagePlaceholder")
                fetchCharacterImage(with: urlString)
            }
            
        }else{
            self.imageView.isHidden = true;
            self.titleLabel.isHidden = true;
            self.textView.isHidden = true;
            
        }
        
    }
    
    
    
    private func fetchCharacterImage(with urlString : String) {
        
        dataManager.characterImage (with : urlString) { image, error in
            
            DispatchQueue.main.async {
                
                self.imageView.isHidden = false;
                self.titleLabel.isHidden = false;
                self.textView.isHidden = false;
                
            }
            
            if let image = image {
                
                DispatchQueue.main.async {
                     self.imageView.image = image
                    
                    if let delegate = self.delegate, let viewModel = self.viewModel, let index = viewModel.characterDetailData.index{
                        
                        delegate.updateImage(sender : self, image: image, for: index)
                    }
                    
                }
            }else{
                
                // error handling
            }
            
        }
    }
    
    var detailItem: NSDate? {
        didSet {
           
        }
    }

   
}

