//
//  HomeViewController.swift
//  Test
//
//  Created by Brinit on 08/09/25.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var notes = [NotesUserModel]()


    @IBOutlet weak var noteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        noteTableView.delegate = self
        noteTableView.dataSource = self
        
        fetchNotes()

    }
    
//MARK: - TableView Configration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NoteTableViewCell
        let tableData = notes[indexPath.row]
        cell.titleLabel.text = tableData.title
        cell.noteImage.image = tableData.image
        cell.descLabel.text = tableData.description
        return cell
    }
    
  //MARK: - Add Note Configration
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func fetchNotes(){
        
        notes.append(NotesUserModel(title: "Title1", image: UIImage(named: "1")!, description: "Beneath the shimmering surface of the ocean lies a mysterious and enchanting world that feels almost otherworldly. The underwater realm is a place of breathtaking beauty, hidden wonders, and delicate ecosystems that sustain life on Earth in ways we often overlook. From the shallow coral reefs glowing with vibrant colors to the darkest depths where strange bioluminescent creatures drift through eternal night, the diversity of life below the waves is both astonishing and humbling."))
        notes.append(NotesUserModel(title: "Title2", image: UIImage(named: "2")!, description: "Beneath the shimmering surface of the ocean lies a mysterious and enchanting world that feels almost otherworldly. The underwater realm is a place of breathtaking beauty, hidden wonders, and delicate ecosystems that sustain life on Earth in ways we often overlook. From the shallow coral reefs glowing with vibrant colors to the darkest depths where strange bioluminescent creatures drift through eternal night, the diversity of life below the waves is both astonishing and humbling."))
        notes.append(NotesUserModel(title: "Title3", image: UIImage(named: "3")!, description: "Beneath the shimmering surface of the ocean lies a mysterious and enchanting world that feels almost otherworldly. The underwater realm is a place of breathtaking beauty, hidden wonders, and delicate ecosystems that sustain life on Earth in ways we often overlook. From the shallow coral reefs glowing with vibrant colors to the darkest depths where strange bioluminescent creatures drift through eternal night, the diversity of life below the waves is both astonishing and humbling."))
        notes.append(NotesUserModel(title: "Title4", image: UIImage(named: "4")!, description: "Beneath the shimmering surface of the ocean lies a mysterious and enchanting world that feels almost otherworldly. The underwater realm is a place of breathtaking beauty, hidden wonders, and delicate ecosystems that sustain life on Earth in ways we often overlook. From the shallow coral reefs glowing with vibrant colors to the darkest depths where strange bioluminescent creatures drift through eternal night, the diversity of life below the waves is both astonishing and humbling."))
        notes.append(NotesUserModel(title: "Title5", image: UIImage(named: "5")!, description: "Beneath the shimmering surface of the ocean lies a mysterious and enchanting world that feels almost otherworldly. The underwater realm is a place of breathtaking beauty, hidden wonders, and delicate ecosystems that sustain life on Earth in ways we often overlook. From the shallow coral reefs glowing with vibrant colors to the darkest depths where strange bioluminescent creatures drift through eternal night, the diversity of life below the waves is both astonishing and humbling."))
    }

}
