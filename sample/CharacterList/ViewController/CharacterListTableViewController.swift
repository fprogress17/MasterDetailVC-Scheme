//
//  MasterViewController.swift
//  sample
//
//  Created by ᗧ•• Lee on 1/25/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import UIKit

class CharacterListTableViewController: UITableViewController {

    var detailViewController: CharacterDetailViewController? = nil
    var objects = [Any]()

    var collectionView : UICollectionView?
    var tableViewCopy: UITableView?
    
    // MARK : - data manager
     lazy var dataManager = {
        
        return DataManager(baseURL: API.BaseURL)
    }()
    
    var viewModel: CharacterListViewModel? {
        didSet {
            updateView()
        }
    }
    
    var delegate : CharacterDetailViewController?
    
    
    // MARK: - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CharacterDetailViewController
        }
        
        setupView()
        fetchCharacterListData ()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
    }
    
 
       // MARK: - Segues
    
    private func setupView() {
        
        setupNaviBar()
        setupTableView()
    }
    
    private func setupNaviBar(){
        
        if !Env.isIpad {
            let toggle = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleTapped))
            
            navigationItem.leftBarButtonItem = toggle
            navigationItem.title = NameConfiguration.name
        }else{
            self.navigationItem.title = NameConfiguration.name
        }
    }
    
    
    private func setupTableView() {
        tableView.dataSource = self;
        
    }
    
    private func setupCollectionView(){
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionView  = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCollectionCell")
        
        collectionView?.backgroundColor = UIColor.white
        
        guard let collectionview = collectionView else{ return }
        
        self.tableViewCopy = tableView
        self.view = collectionview
     
    }
    
    
        // MARK: - Fetch
    
    private func fetchCharacterListData() {
        
        dataManager.characterData { characterData, error in
            
            if let characterData = characterData{
                self.viewModel = CharacterListViewModel(characterData: characterData)
            }
            
        }
    }
    
    
      // MARK: - updateView
    
    private func updateView(){
        
        guard viewModel != nil else{ return }
        
        if(tableView != nil){
            tableView.reloadData()
        }
        
        if(collectionView != nil){
            collectionView?.reloadData()
        }
    }

   

 

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
  
             if let indexPath = tableView.indexPathForSelectedRow {

                let controller = (segue.destination as! UINavigationController).topViewController as! CharacterDetailViewController
                
                controller.viewModel = CharacterDetailViewModel(characterDetailData : (self.viewModel?.characterData[indexPath.row])!)
                controller.delegate = self;
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true

            }
          }
        
        }
    
    
    // MARK: - toggleTapped
    
     @objc func toggleTapped(){
   
            if collectionView == nil {
                  setupCollectionView()
            }else{
                   self.view = self.tableViewCopy
                   collectionView?.removeFromSuperview()
                   collectionView = nil
            }
 
        
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfCharacters
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseIdentifier, for: indexPath) as? CharacterTableViewCell else { fatalError("Unexpected Table View Cell") }
        
        if let viewModel = viewModel {
           
            cell.textLabel?.text = viewModel.title(for: indexPath.row)
            cell.tag = indexPath.row
            
        }
        
        return cell
    }
  
}



extension CharacterListTableViewController : CharacterDetailViewControllerDelegate{
    
    
    func updateImage(sender: Any, image : UIImage, for index : Int ){
        
        viewModel?.characterData[index].image = image
    }
    
}
