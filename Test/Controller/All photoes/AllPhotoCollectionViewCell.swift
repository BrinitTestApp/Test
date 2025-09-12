//
//  AllPhotoCollectionViewCell.swift
//  Test
//
//  Created by Brinit on 13/09/25.
//

import UIKit

class AllPhotoCollectionViewCell: UICollectionViewCell {
    
    var photoRow: NotePhotoes?{
        didSet {
            allPhotoImage.image = UIImage(data: (photoRow?.noteAllImages)!) 
        }
    }
    
    
    @IBOutlet weak var allPhotoImage: UIImageView!
    
    
    
}
