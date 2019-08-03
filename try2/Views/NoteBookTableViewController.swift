
//  NoteBookTableViewController.swift
//  CrushThisTestNoteApp
//
//  Created by Ian Hall on 8/2/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//
//Gameplan
//step one- delete trash code make it clean
//step2 set up cells
//step3 set up segue
//step4 add load to persistence in here so it loads the data correctly
import UIKit

class NoteBookTableViewController: UITableViewController, UISearchBarDelegate {
    
    //editing related variables
    var deleteButtonVisible:UITableViewCell.EditingStyle = .none
    var editingStyleIsActive = false
    
    //search related variables
    @IBOutlet weak var searchBar: UISearchBar!
    var isUserSearching = false
    var filteredData = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = true
        
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //load data
        NoteController.sharedInstance.loadFromPersistentStorage()
        //reload the table to show anything that may have changed
        tableView.reloadData()
    }
    
    //MARK: ACTIONS
    
    
    
    
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isUserSearching {
            return filteredData.count
        } else{
        return NoteController.sharedInstance.noteBook.count
    }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let text: String!
        
        if isUserSearching {
            text = filteredData[indexPath.row].text
            cell.textLabel?.text = text
        } else {
        //grab the text data from it and smack in on the cell
        cell.textLabel?.text = NoteController.sharedInstance.noteBook[indexPath.row].text
        }
        return cell
    }
//
//    let movedObject = NoteController.sharedInstance.noteBook[sourceIndexPath.row]
//    NoteController.sharedInstance.noteBook.remove(at: sourceIndexPath.row)
//    NoteController.sharedInstance.noteBook.insert(movedObject, at: destinationIndexPath.row)
//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isUserSearching = false
            
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isUserSearching = true
            var objectList: [Note] = []
            for entry in NoteController.sharedInstance.noteBook {
                if entry.text.contains(searchBar.text!){
                    objectList.append(entry)
                }
                
            }
            filteredData = objectList
            tableView.reloadData()
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete the instance
            NoteController.sharedInstance.deleteNote(note: NoteController.sharedInstance.noteBook[indexPath.row])
            //delete the cell
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //im the delete button
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if deleteButtonVisible == .none{
            self.tableView.isEditing = true
            deleteButtonVisible = .delete
            
        } else{
            self.tableView.isEditing = false
            deleteButtonVisible = .none
            
        }
        NoteController.sharedInstance.saveToPersistentStorage()
        tableView.reloadData()
    }
    // im a bunch of stuff i need to delete stuff and move stuff≈
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return deleteButtonVisible
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = NoteController.sharedInstance.noteBook[sourceIndexPath.row]
        NoteController.sharedInstance.noteBook.remove(at: sourceIndexPath.row)
        NoteController.sharedInstance.noteBook.insert(movedObject, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    //IIDOO
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        deleteButtonVisible = .none
        //identify correct segue
        if segue.identifier == "editSegue"{
            //index
            if let indexPath = tableView.indexPathForSelectedRow{
                //destination
                if let destinationDVC = segue.destination as? NoteViewController {
                    //object prep
                    let objectToSend = NoteController.sharedInstance.noteBook[indexPath.row]
                    //object land
                    destinationDVC.landingPad = objectToSend
                }
            }
        }
        
    }
    
    
}

