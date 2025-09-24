//
//  AddNoteViewController.swift
//  Test
//
//  Created by Brinit on 10/09/25.
//

import UIKit
import PhotosUI

class AddNoteViewController: UITableViewController,UITextViewDelegate {
    
    //MARK: - Costume DelegateMethods
    
    //MARK: - Variables
    
    var selectedTitle: String?
    var selectedNote: String?
    var selectedImage: [UIImage] = []
    var userNote: NoteDetails?
    var allNotes = [NoteDetails]()
    var allUser = [UserEmails]()
    var getEmailUser: UserEmails?
    //fetching email from loging page (not core data )

    //MARK: - Outlets
    
    @IBOutlet weak var addNoteImageView: UIImageView!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorNote: UILabel!
    @IBOutlet weak var addTitleTextField: UITextField!
    @IBOutlet weak var addNoteTextField: UITextView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addNoteTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

   
    func setupUI() {
        //imageView
        
        addNoteImageView.isHidden = true
        
        
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
        
        
        addTitleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        hideError()
    }
    
    @objc private func textFieldDidChange() {
        hideError()
    }
    
    
    
    // MARK: - UI Feedback
    private func showError(message: String, textLabel: UILabel) {
        textLabel.text = message
        textLabel.isHidden = false
        
        // Add shake animation
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textLabel.center.x - 5, y: textLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textLabel.center.x + 5, y: textLabel.center.y))
        textLabel.layer.add(animation, forKey: "position")
    }
    
    private func hideError() {
        errorNote.isHidden = true
        errorTitle.isHidden = true
    }
    
    
    //MARK: - Data Manupilations
    
    func addTitleToNote(){
        
        guard let trimmedTitle = addTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmedTitle.isEmpty else {
            let alert = UIAlertController(title: "Oops!", message: "please write Something in title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            showError(message: "please write Something...!", textLabel: errorTitle)
            return
        }
        
        if trimmedTitle.count < 5 || trimmedTitle.count > 100{
            let alert = UIAlertController(title: "Oops!", message: "Title min 5 characters, max 100 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            showError(message: "min 5 characters, max 100 characters...!", textLabel: errorTitle)
            return
        }else{
            
            selectedTitle = trimmedTitle
            
        }
    }
    
    
    func addNotesToNotes(){
        
        guard let trimmedNotes = addNoteTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmedNotes.isEmpty else {
            let alert = UIAlertController(title: "Oops!", message: "please write Something in Notes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            showError(message: "please write Something...!", textLabel: errorNote)
            return
        }
        if trimmedNotes.count < 100 || trimmedNotes.count > 1000{
            let alert = UIAlertController(title: "Oops!", message: "Notes min 100 characters, max 1000 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            showError(message: "min 100 characters, max 1000 characters...!", textLabel: errorNote)
            return
            
        }else{
            selectedNote = trimmedNotes
            
        }
        
        
    }
    
    
//MARK: - Adding Core Data Operations

    func addingData(){
        addTitleToNote()
        addNotesToNotes()
    }
    func addingDatatoDB(){
        
        guard !selectedImage.isEmpty else {
            let alert = UIAlertController(title: "Oops!", message: "please select image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        guard let selectedTitle = selectedTitle, let selectedNote = selectedNote else {
            print("Error Saving Core Data Note And Decriptions")
            return
        }
        guard !selectedImage.isEmpty else{
            print("Error Saving Core Data Note And Decriptions")
            return
        }
            addingNotes(note: selectedTitle, dec: selectedNote , photo: selectedImage[0])

     
     

    }
    func addingImageData(){
        
        guard !selectedImage.isEmpty else {
            let alert = UIAlertController(title: "Oops!", message: "please select image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        allNotes = DatabaseHelper.shareInstance.fetchingNote()
        userNote = allNotes.last
        guard let activeUser = userNote else{
            print("Error Loggedin Notes....!!!  note not find From CoreData...!!!")
            return}
        addingImagestoCoreData(image: selectedImage, note: activeUser)
    }
    
    
    
    
    
   
}
//MARK: - AddNoteActions
extension AddNoteViewController {
    
    @IBAction func addPhotoTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Photo", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCameraPicker()
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.openPhotoPicker()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cameraAction)
        alert.addAction(photoLibraryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    @IBAction func addNoteTapped(_ sender: UIButton) {
        addingData()
        addingDatatoDB()
        addingImageData()
        navigationController?.popViewController(animated: true)
    }

}
// MARK: - UITextFieldDelegate
extension AddNoteViewController: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addTitleTextField {
            addNoteTextField.becomeFirstResponder()
        } else if textField == addNoteTextField {
            textField.resignFirstResponder()
            addingData()
            return true
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}



//MARK: - Adding Photos Functionality

extension AddNoteViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 1. Add a button to trigger the photo picker
    func openPhotoPicker() {
        // 2. Configure the picker
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 10 //  limit
        configuration.filter = .images
        configuration.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    // 4. Implement the delegate method
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        // Dismiss the picker
        guard !results.isEmpty else { return }
        
        // 5. Process the results
        
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                            return
                        }
                        
                        if let image = image as? UIImage {
                            self?.selectedImage.append(image)
                        }
                    }
                }
                
            }
        }
    }
    func openCameraPicker(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        present(cameraPicker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        let cameraImage = info[UIImagePickerController.InfoKey.originalImage]  as? UIImage
        
        
        
        if let image = cameraImage {
            // Append the selected image to your array
            
            self.selectedImage.append(image)
          
            
            
            // Update your UI on the main thread
            DispatchQueue.main.async {
                self.addNoteImageView.isHidden = false
                if let imageAvailable = self.selectedImage.first {
                    self.addNoteImageView.image = imageAvailable
                    print("Image selected and loaded.")
                }
                
            }
            
        }
    }
}

//MARK: - Saving Data in Core Data
extension AddNoteViewController {
    
    func addingNotes(note: String, dec: String, photo: UIImage){
        guard let activeUser = getEmailUser else{
            print("Error Loggedin Notes....!!!  Email not find From CoreData...(single Pic DB)!!!")
            return}
        DatabaseHelper.shareInstance.saveNote(note: note, description: dec, photo: photo, email: activeUser)
        
    }
    
    func addingImagestoCoreData(image: [UIImage], note: NoteDetails){
        guard let activeNote = userNote else{
            print("Error Loggedin Notes....!!!  Email not find From CoreData...!!!(multiple Pic DB)!!!")
            return}

        DatabaseHelper.shareInstance.saveImage(image: image, note: activeNote)
    }
    
}



