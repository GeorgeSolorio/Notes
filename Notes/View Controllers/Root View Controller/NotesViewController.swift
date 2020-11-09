//
//  ViewController.swift
//  Notes
//
//  Created by George Solorio on 11/2/20.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

   // MARK: - Properties
   private enum Segue {
      
      static let AddNote = "AddNote"
      
   }
   
   private var coreDataManager = CoreDataManager(modelName: "Notes")
   
   // MARK: - View lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
            
   }
   
   
   // MARK: - Navigation
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      guard let identifier = segue.identifier else {
         return
      }
      
      switch identifier {
      case Segue.AddNote:
         guard let destination = segue.destination as? AddNoteViewController else {
            return
         }
         
         destination.managedObjectContext = coreDataManager.managedObjectContext
      default:
         break
      }
   }
}

