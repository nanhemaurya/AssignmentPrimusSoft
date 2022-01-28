//
//  MainVC.swift
//  Assignment
//
//  Created by SMN Boy on 28/01/22.
//

import UIKit


class MainVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = MainViewModel()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerWithNib(cell: ImageCell.self)
        collectionView.registerWithNib(cell: ToolbarCell.self)
        collectionView.registerWithNib(cell: ShowMore.self)
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = (2 * flowLayout.minimumInteritemSpacing)
        collectionView.collectionViewLayout = flowLayout
        viewModel.loadData()
        
        // Do any additional setup after loading the view.
    }
    
}

extension MainVC: MainViewModelDelegate {
    func onError(error: Error) {
        print(error.localizedDescription)
    }
    
    func onDataLoaded() {
        collectionView.reloadData()
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getDataCount() + ((self.viewModel.isMoreDataToShow) ? 1 : 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        
        if viewModel.getDataCount() == indexPath.item && self.viewModel.isMoreDataToShow {
            collectionView.allowsSelection = true
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShowMore.self), for: indexPath) as! ShowMore
            
            cell.showMoreBtn.onTap {
                self.viewModel.loadMoreData()
            }
            
            return cell
        }
        
        let data = viewModel.getData(at: indexPath.item)
        switch data.appDataEnum {
            case .toolbar:
                let toolbarCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ToolbarCell.self), for: indexPath) as! ToolbarCell
                cell = toolbarCell
                if let user = data.data as? UserData {
                    toolbarCell.userImageView.loadImageUsingUrlString(urlString: user.imageUrl)
                    toolbarCell.userImageView.rounded()
                    toolbarCell.userNameLbl.text = user.name
                }
                
                break
                
            case .even, .odd:
               let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as! ImageCell
                if let imageUrl = data.data as? String {
                    imageCell.imageView.loadImageUsingUrlString(urlString: imageUrl)
                }
                cell = imageCell
                break
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if viewModel.getDataCount() == indexPath.item && self.viewModel.isMoreDataToShow {
            let size = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
            return CGSize(width: size, height: 50.0)
        }
        
        let data = viewModel.getData(at: indexPath.item)
        switch data.appDataEnum {
            case .toolbar:
                let size = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
                return CGSize(width: size, height: 50.0)
                
            case .even:
                let totalInsetWidth = (collectionView.contentInset.left/2 + collectionView.contentInset.right/2)
                let size = (collectionView.frame.width / 2) - (totalInsetWidth/2) - totalInsetWidth
                return CGSize(width: size, height: size)
                
            case .odd:
                let size = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
                return CGSize(width: size, height: size)
        }
    }
    
    
    
}




