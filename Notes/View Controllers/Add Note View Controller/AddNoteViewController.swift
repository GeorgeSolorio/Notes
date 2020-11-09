//
//  AddNoteViewController.swift
//  Notes
//
//  Created by George Solorio on 11/8/20.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
   
   @IBOutlet var titleTextField: UITextField!
   @IBOutlet var contentsTextView: UITextView!
   
   var managedObjectContext: NSManagedObjectContext?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      titleTextField.becomeFirstResponder()
   }
   
   @IBAction func save(sender: UIBarButtonItem) {
      
      guard let managedObjectContext = managedObjectContext else { return }
      
      guard let title = titleTextField.text, !title.isEmpty else {
         showAlert(with: "Title Missing", and: "Your note doesn't have a tittle.")
         return
      }
      
      let note = Note(context: managedObjectContext)
      
      note.createdAt = Date()
      note.updatedAt = Date()
      note.title = title
      note.contents = contentsTextView.text
      
      do {
         try managedObjectContext.save()
      } catch {
         print("Unable to Save Managed Object Context")
         print("\(error) \(error.localizedDescription)")
      }
      
      _ = navigationController?.popViewController(animated: true)
   }
}

