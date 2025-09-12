//
//  NoteTableViewCell.swift
//  Test
//
//  Created by Brinit on 10/09/25.
//

import UIKit



class HomeTableViewCell: UITableViewCell {
    
    var noteRow: NoteDetails?{
        didSet {
            titleLabel.text = noteRow?.noteTitle
            descLabel.text = noteRow?.noteDescription
            noteImage.image = UIImage(data: (noteRow?.noteImage)!)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var noteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
