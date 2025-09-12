//
//  HomeViewController.swift
//  Test
//
//  Created by Brinit on 08/09/25.
//

import UIKit



class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, emailDelegate {
    
    
    var notes = [NoteDetails]()
    var user : UserEmails?
    var photoUser: NotePhotoes?
    var fetchEmail: String?
    
//    var selectedEmailuser: UserEmails?{
//        didSet{
//            fetchingUserDetails()
//            noteTableView.reloadData()
//        }
//    }




    @IBOutlet weak var noteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        noteTableView.delegate = self
        noteTableView.dataSource = self
        self.hideKeyboardWhenTappedAround()
//        self.notes = DatabaseHelper.shareInstance.fetchingNote()

       
    }
    
    func getEmail(email: UserEmails) {
        user = email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if user?.noteAccess?.allObjects != nil{
            notes = user?.noteAccess?.allObjects as! [NoteDetails]
        }
//        self.notes = DatabaseHelper.shareInstance.fetchingNote()
        noteTableView.reloadData()
    }
    
//MARK: - TableView Configration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notes.isEmpty{
            return 1
        }else {
            return notes.count
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        
        if notes.isEmpty{
            cell.titleLabel.text = "No Notes Available please add using + button"
            cell.descLabel.text = "Not Available Descriptions"
            cell.noteImage.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill")
            return cell
        }else{
            cell.noteRow = notes[indexPath.row]
            return cell
        }

        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AllPhotoesViewController") as? AllPhotoesViewController{
            vc.noteData = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  //MARK: - Add Note Configration
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController{
            vc.getEmailUser = fetchEmail
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}
