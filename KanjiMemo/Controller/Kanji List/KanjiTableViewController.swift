//
//  KanjiTableViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 15/11/2020.
//

import UIKit

class KanjiTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlet of the table view
    @IBOutlet weak var kanjiTableView: UITableView!
    
    // Outlet to display the number of kanji
    @IBOutlet weak var numberOfKanji: UILabel!
    
    // Kanji list to be reloaded outside the main queue
    var listKanji = [Kanji]() {
        didSet {
            DispatchQueue.main.async {
                self.kanjiTableView.reloadData()
            }
        }
    }
    
    // To pass data to the detailled view
    var kanjiDetailData: Kanji!
    
    //Instance of json decoder
    var decoder = KanjiJsonDecoder(session: URLSession(configuration: .default))
    
    // Search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    // List of kanji filtered by the search bar
    var filteredKanji: [Kanji] = []
    
    // Search bar is empty
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // Search is filetring
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // Boolean to see if button od selected kanji display is active or not
    var displaySelectedKanji = false
    
    // Parameter used to attribute filteredKanji array or listActivatedKAnji
    var kanjiFromThisCell: Kanji!
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Kanji"
        
        // Call the decode methed
        decoder.decodeKanjiJson{[weak self] result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                print(error)
            case .success(let kanji):
                // en cas de success, attribuer les data extraites à la liste de user
                self?.listKanji = kanji
            //print(kanji)
            }
        }
        
        //Search bar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search English translation"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }

    
    // MARK: Filtering method
    func filterContentForSearchText(_ searchText: String,
                                    category: Kanji? = nil) {
        
        // Create list of filtered kanji
        filteredKanji = listKanji.filter { (kanji: Kanji) -> Bool in
            return kanji.meanings.joined(separator:", ").lowercased().contains(searchText.lowercased())
        }
        
        // If no result from the search
        if filteredKanji == [] {
            numberOfKanji.text = "No Kanji found"
        }
        
        kanjiTableView.reloadData()
    }
    
    // Button to show only selected Kanji
    @IBAction func displayOnlySelectedKanji(_ sender: Any) {
        // If no kanji selected
        if CardCreator.cardCreator.listActivatedKAnji == [] {
            numberOfKanji.text = "No Kanji selected"
        }
        
        if displaySelectedKanji == false {
            displaySelectedKanji = true
        } else {
            displaySelectedKanji = false
        }
        
        kanjiTableView.reloadData()
        
    }
    
    
    // MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If filter
        if isFiltering {
            return filteredKanji.count
        } else if displaySelectedKanji {
            // Else if button "display selected kanji" is active
            return CardCreator.cardCreator.listActivatedKAnji.count
        }
        
        // If no filter
        return listKanji.count
    }
    
    
    
    // Attribute filtered array if filter is active
    func attributeKanjiFromCorrectList(row: Int){
        // Text after the count of kanji
        let kanjiNumberText = " Kanji displayed"
        
        if isFiltering {
            kanjiFromThisCell = filteredKanji[row]
            // Number of kanji displayed
            numberOfKanji.text = String(filteredKanji.count) + kanjiNumberText
            
        } else if displaySelectedKanji {
            kanjiFromThisCell = CardCreator.cardCreator.listActivatedKAnji[row]
            // Number of kanji displayed
            numberOfKanji.text = String(CardCreator.cardCreator.listActivatedKAnji.count) + kanjiNumberText
            
        } else {
            kanjiFromThisCell = listKanji[row]
            // Number of kanji displayed
            numberOfKanji.text = String(listKanji.count) + kanjiNumberText
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KanjiCell", for: indexPath) as? KanjiTableViewCell
        
        // Call method to take kani from filetred list if filter is active
        attributeKanjiFromCorrectList(row: indexPath.row)
        
        // Compare list of activated kanji with actual kanji to activate switch for reusable cell
        if CardCreator.cardCreator.listActivatedKAnji.contains(kanjiFromThisCell) {
            cell?.kanjiSwitch.isOn = true
        }
        
        // Attribute Kanji
        cell?.kanjiLabel.text = kanjiFromThisCell.kanji
        
        // Attribute the english translation
        let meaningsString = kanjiFromThisCell.meanings.joined(separator:", ")
        cell?.englishLabel.text = meaningsString
        
        // Attribute the pronouciation in hiragana/katakana
        let kanaString = kanjiFromThisCell.kun_readings.joined(separator:", ")
        cell?.kanaLabel.text = kanaString
        
        // Switch
        cell?.kanjiSwitch.tag = indexPath.row
        cell?.kanjiSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        return cell!
    }
    
    
    //MARK: Switch method
    @objc func switchChanged(_ sender : UISwitch!){
        
        // Call method to take kanji from filetred list if filter is active
        attributeKanjiFromCorrectList(row: sender.tag)
        
        // Check status of th quizz
        if QuizzGame.quizzGame.quizzIsOn == false {
            // Check status of switch
            if sender .isOn {
                //Append listActivatedKAnji
                CardCreator.cardCreator.listActivatedKAnji.append(kanjiFromThisCell)
                //print(listActivatedKAnji)

            } else {
                //Remove from listActivatedKAnji
                if let index = CardCreator.cardCreator.listActivatedKAnji.firstIndex(of: kanjiFromThisCell) {
                    CardCreator.cardCreator.listActivatedKAnji.remove(at: index)
                }
                //print(listActivatedKAnji)
                kanjiTableView.reloadData()
            }
        } else {
            // If the quizz is on, don't allow to change the kanji selection
            alert(title: "Error", message: "Please finish the quizz before changing the Kanji selection.")
            // Keep the switch in their position
            if sender.isOn {
                sender.setOn(false, animated: true)
            } else {
                sender.setOn(true, animated: true)
            }
        }
        
    }
    
    
    // MARK: TableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if filtering
        attributeKanjiFromCorrectList(row: indexPath.row)
        
        // attribute the data
        let detailledKanji = kanjiFromThisCell
        
        kanjiDetailData = detailledKanji
        
        performSegue(withIdentifier: "toKanjiDetail", sender: nil)
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toKanjiDetail" {
            let detailVC = segue.destination as! KanjiDetailViewController
            detailVC.kanjiDetailData = kanjiDetailData
        }
    }
    
    // Method to call an alert
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: Extension for search bar
extension KanjiTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}


