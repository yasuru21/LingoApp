//
//  TableViewController.swift
//  LingoApp
//
//  Created by Michael Quinn on 4/16/21.
/*
 Michael Quinn - michquin@iu.edu
 Ian McLoud - imcloud@iu.edu
 Yash Asuru - yasuru@iu.edu
 */
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    var myAppDelegate: AppDelegate?
    var myWordData: WordModel?
    var searchedWordObjects: [WordObject]!

    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myAppDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myWordData = self.myAppDelegate?.myWordData
        searchedWordObjects = self.myWordData?.wordData
        self.searchBar.delegate = self
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // Will have one section with all the words displayed as cells
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //will have to return array.size
        //right now return 50 cells, but eventually it will have to return the size of the array
        //this is so the table can display all words from the array without any errors
        
        return searchedWordObjects.count
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordDef", for: indexPath) as! TableViewCell

        // Configure the cell...
        
        /*
         1. Instiantiate the data model to be used
         2. link the data from the cell to the word array so those words can be used here
         3. edit the style of the cell all we want (optional)
         4. set the cells data to change to data from the stored word array
         5. Wite the cell data to the persistent storage file
         6. return the cell
         */
        
        cell.wordTableLabel.text = searchedWordObjects[indexPath.row].myWord
        cell.defTableLabel.text = searchedWordObjects[indexPath.row].myDefinition
        cell.speechTableLabel.text = searchedWordObjects[indexPath.row].myPartOfSpeech

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*
         this function will be ran when someone is operating the search bar which will 'slim down' optionality of words/defs once you start typing
         also includes all logic for search bar
         */
        
        let allObjects = myWordData?.wordData
        searchedWordObjects = []
        
        if searchText == ""{
            searchedWordObjects = allObjects
        }
        else{
            for object in allObjects!{
                if object.myWord.lowercased().contains(searchText.lowercased()){
                    searchedWordObjects.append(object)
                }
            }
        }
        self.tableView.reloadData()
    }

}
