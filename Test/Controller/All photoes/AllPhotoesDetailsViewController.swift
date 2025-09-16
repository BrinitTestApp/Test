//
//  AllPhotoesDetailsViewController.swift
//  Test
//
//  Created by Brinit on 13/09/25.
//

import UIKit

class AllPhotoesDetailsViewController: UIViewController {
    

    var noteDataSet : NoteDetails?
    var noteImageSet : NotePhotoes?

 
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataAvailable()
    }
    
    func dataAvailable() {
        imgView.image = UIImage(data: (noteImageSet?.noteAllImages)!)
        lblName.text = noteDataSet?.noteTitle
        lblDesc.text = noteDataSet?.noteDescription
        
        
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
