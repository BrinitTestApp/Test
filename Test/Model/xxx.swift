//
//  NotesUserModel.swift
//  Test
//
//  Created by Brinit on 10/09/25.
//

import Foundation
import UIKit


class NotesUserModel {
    
    var title: String?
    var image: UIImage?
    var description: String?
    var user: String?
    var selectedImages: [UIImage] = []
    
    init(title: String, image: UIImage, description: String) {
        self.title = title
        self.image = image
        self.description = description
    }
}
