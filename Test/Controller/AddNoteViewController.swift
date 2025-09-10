//
//  AddNoteViewController.swift
//  Test
//
//  Created by Brinit on 10/09/25.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorNote: UILabel!
    @IBOutlet weak var addTitleTextField: UITextField!
    @IBOutlet weak var addNoteTextField: UITextView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        // error Title
        
        errorTitle.isHidden = true
        errorNote.isHidden = true
        errorTitle.textColor = .red
        errorNote.textColor = .red
        
        
        //TextField
        
        addNoteTextField.layer.cornerRadius = 10
        addNoteTextField.layer.borderWidth = 1
        addNoteTextField.layer.borderColor = UIColor.lightGray.cgColor
        addTitleTextField.layer.cornerRadius = 10
        addTitleTextField.layer.borderWidth = 1
        addTitleTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        //Buttons
        
        addPhotoButton.layer.cornerRadius = 8
        addPhotoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        saveButton.layer.cornerRadius = 8
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

    @IBAction func addPhotoTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func addNoteTapped(_ sender: UIButton) {
    }
}
