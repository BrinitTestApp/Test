//
//  AllPhotoesViewController.swift
//  Test
//
//  Created by Brinit on 13/09/25.
//

import UIKit
import CoreData


class AllPhotoesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var allPhoto = [NotePhotoes]()
    var noteData:NoteDetails?
    
    //MARK:- IBOutlets
    @IBOutlet weak var allPhotoCollectioView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allPhotoCollectioView.delegate = self
        allPhotoCollectioView.dataSource = self
        self.allPhoto = DatabaseHelper.shareInstance.fetchingAllImages()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        allPhotoCollectioView.reloadData()
    }
    enum ScreenSize: Int {
        case WIDTH
        case HEIGHT
        
        var value: CGFloat {
            switch self {
            case .WIDTH: return UIScreen.main.bounds.width
            case .HEIGHT: return UIScreen.main.bounds.height
            }
        }
        
        
        func cellHeightWidth(by itemSpacing: CGFloat, noOfItems: Int, sideSpacing: CGFloat) -> CGFloat {
            let valueToBeSubtracted = (sideSpacing * 2) + (itemSpacing * CGFloat(noOfItems - 1))
            let totalWidthOrHeight = self.value - valueToBeSubtracted
            let cellWidthHeight = totalWidthOrHeight / CGFloat(noOfItems)
            return cellWidthHeight
        }
        
    }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return allPhoto.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = allPhotoCollectioView.dequeueReusableCell(withReuseIdentifier: "allPhotoCell", for: indexPath) as! AllPhotoCollectionViewCell
            cell.photoRow = allPhoto[indexPath.row]
            return cell
            }
           
        
        //MARK:- UICollectionViewDelegate
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let destVC = storyboard?.instantiateViewController(withIdentifier: "AllPhotoesDetailsViewController") as? AllPhotoesDetailsViewController{
                destVC.noteImageSet = allPhoto[indexPath.row]
                destVC.noteDataSet = noteData
                navigationController?.pushViewController(destVC, animated: true)
            }
          

        }
        
        
    }

//MARK:- UICollectionViewFlowLayoutDelegate
extension AllPhotoesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthHeight = ScreenSize.WIDTH.cellHeightWidth(by: 2, noOfItems: 2, sideSpacing: 2)
        return CGSize.init(width: widthHeight, height: widthHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

