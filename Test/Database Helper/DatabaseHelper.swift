//
//  DatabaseHelper.swift
//  Test
//
//  Created by Brinit on 14/09/25.
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {
    
    static let shareInstance = DatabaseHelper()

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//MARK: - Email Operations Core Data
    //Fetch
    func fetchingEmailData()-> [UserEmails]{
        var arrayOfEmails = [UserEmails]()
        let fetchRequest: NSFetchRequest<UserEmails> = UserEmails.fetchRequest()
        do {
            arrayOfEmails = try context.fetch(fetchRequest)
        }catch let emailFetchingError{
            print("CoreData::- Error Fetching Email:- \(emailFetchingError.localizedDescription)")
        }
        return arrayOfEmails
    }
    //Save
    func saveUserEmailData(email: String) {
        
        let emailSaving = NSEntityDescription.insertNewObject(forEntityName: "UserEmails", into: context) as! UserEmails
        emailSaving.email = email
        
        do {
            try context.save()
        }catch let emailError{
            print("CoreData::- Error Saving Email:- \(emailError.localizedDescription)")
        }
        
    }
    
    
    //MARK: - Adding Note and Image Operations
    
    //Fetch
    func fetchingNote()-> [NoteDetails]{
        var arrayOfNotes = [NoteDetails]()
        let fetchRequest: NSFetchRequest<NoteDetails> = NoteDetails.fetchRequest()
        do {
            arrayOfNotes = try context.fetch(fetchRequest)
        }catch let noteFetchingError{
            print("CoreData::- Error Fetching Email:- \(noteFetchingError.localizedDescription)")
        }
        return arrayOfNotes
    }
    
    //Save
    func saveNote(note: String, description: String, photo: UIImage, email: UserEmails) {
        
        let noteSaving = NSEntityDescription.insertNewObject(forEntityName: "NoteDetails", into: context) as! NoteDetails
        noteSaving.noteTitle = note
        noteSaving.noteDescription = description
        let imageData = photo.jpegData(compressionQuality: 1)
        noteSaving.noteImage = imageData
        noteSaving.parentEmail = email
        
        do {
            try context.save()
        }catch let noteError{
            print("CoreData::- Error Saving Email:- \(noteError.localizedDescription)")
        }
        
    }
    
//MARK: - Adding More Images Operations
    
    
    //Fetch
    
    func fetchingAllImages()-> [NotePhotoes]{
        
        var arrayOfAllImages = [NotePhotoes]()
        let fetchRequest: NSFetchRequest<NotePhotoes> = NotePhotoes.fetchRequest()
        do {
            arrayOfAllImages = try context.fetch(fetchRequest)
        }catch let allImagesFetchingError{
            print("CoreData::- Error Fetching All Images:- \(allImagesFetchingError.localizedDescription)")
        }
        return arrayOfAllImages
    }
    //Save
    func saveImage(image: [UIImage]) {

        
        for singleImage in image {
            let allImageSaving = NSEntityDescription.insertNewObject(forEntityName: "NotePhotoes", into: context) as! NotePhotoes
            
            let imageData = singleImage.jpegData(compressionQuality: 1)
            allImageSaving.noteAllImages = imageData
        }
            do {
                try context.save()
            }catch let imagesError{
                print("CoreData::- Error Saving Images:- \(imagesError.localizedDescription)")
            }
        }
}
