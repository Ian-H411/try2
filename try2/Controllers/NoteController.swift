//
//  NoteController.swift
//  CrushThisTestNoteApp
//
//  Created by Ian Hall on 8/2/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

class NoteController{
    //Single Instance
    static var sharedInstance = NoteController()
    //source of truth!
    var noteBook: [Note] = []
    
    //CRUD to follow
    
    //Create
    
    func createNewNote(text: String){
        let newNote = Note(text: text)
        noteBook.append(newNote)
        saveToPersistentStorage()
    }
    //read - see persistence below
    
    //update
    func updateNote(new text: String, note: Note){
        note.text = text
        saveToPersistentStorage()
    }
    
    func deleteNote(note: Note){
        //find index in optional
        guard let noteIndex = noteBook.firstIndex(of: note) else {return}
        //use prior index to remove
        noteBook.remove(at: noteIndex)
        
        saveToPersistentStorage()
        
    }
    
    //persistence
    
    //first we gotta find a place to build a home
    
    func findFileUrl() -> URL {
        //first find the source of all paths
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //grab the first location
        let documentDirectory = paths[0]
        //make up a name
        let fileName = "superAwesomeNoteApp.json"
        //now the final touch creating our URL
        let fullUrl = documentDirectory.appendingPathComponent(fileName)
        return fullUrl
        
    }
    //function to save data
    func saveToPersistentStorage() {
        //first we create an encoder
        let encoder = JSONEncoder()
        //prep a do try catch
        do{//try to encode
            let data = try encoder.encode(noteBook)
            //try to write
            try data.write(to: findFileUrl())
            //if it cant and it fails give me the error message
        } catch let errorMessage{
            //and print the message here
            print(errorMessage.localizedDescription)
        }
    }
    func loadFromPersistentStorage(){
        // create our decoder
        let decoder = JSONDecoder()
        do{//go to where it should be
            let data = try Data(contentsOf: findFileUrl())
            //after decode data
            let decodedNoteBook = try decoder.decode([Note].self, from: data)
            //put it back where it belongs
            self.noteBook = decodedNoteBook
        } catch let errorMessage{
            print(errorMessage.localizedDescription)
        }
    }
    
    
}

