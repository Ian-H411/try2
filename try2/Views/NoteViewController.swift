//
//  NoteViewController.swift
//  CrushThisTestNoteApp
//
//  Created by Ian Hall on 8/2/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    var landingPad: Note?
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unwrappedLandingPad = landingPad {
            textField.text = unwrappedLandingPad.text
        } else {
            textField.text = ""
        }
        
        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        //if your blank dont waste my time im not gonna save ya
        if textField.text == "" {return}
        if let object = landingPad {
            NoteController.sharedInstance.updateNote(new: textField.text, note: object)
        } else {
            NoteController.sharedInstance.createNewNote(text: textField.text)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}

