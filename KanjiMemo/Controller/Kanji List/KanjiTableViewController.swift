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
    
    // Kanji list to be reloaded oyside the main queue
    var listKanji = [Kanji]() {
        didSet {
            DispatchQueue.main.async {
                self.kanjiTableView.reloadData()
            }
        }
    }
    
    // List of kanji which switch is on
    var listActivatedKAnji: [Kanji] = []
    
    // To pass data to the detailled view
    var kanjiDetailData: Kanji!
    
    //Instance of JSON decoder
    var decoder = KanjiJsonDecoder(session: URLSession(configuration: .default))
    
    // Search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    // List of kanji filtered by the search bar
    var filteredKanji: [Kanji] = []
    
    // Search bar is empty
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    // Parameter used to attribute filteredKanji array or listActivatedKAnji
    var kanjiUpdatedList: Kanji!

    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
      filteredKanji = listKanji.filter { (kanji: Kanji) -> Bool in
        return kanji.meanings.joined(separator:", ").lowercased().contains(searchText.lowercased())
      }
        kanjiTableView.reloadData()
    }


    // MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If filter
        if isFiltering {
            return filteredKanji.count
          }
        
        // If no filter
        return listKanji.count
    }
    
    
    
    // Attribute filtered array if filter is active
    func attributeKanjiFromCorrectList(row: Int){
        if isFiltering {
          kanjiUpdatedList = filteredKanji[row]
        } else {
          kanjiUpdatedList = listKanji[row]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KanjiCell", for: indexPath) as? KanjiTableViewCell
        
        // Call method to take kani from filetred list if filter is active
        attributeKanjiFromCorrectList(row: indexPath.row)
        
        
        // Compare list of activated kanji with actual kanji to activate switch for reusable cell
        if listActivatedKAnji.contains(kanjiUpdatedList) {
            cell?.kanjiSwitch.isOn = true
        }
        
        
        // Attribute Kanji
        cell?.kanjiLabel.text = kanjiUpdatedList.kanji
        
        // Attribute the english translation
        let meaningsString = kanjiUpdatedList.meanings.joined(separator:", ")
        cell?.englishLabel.text = meaningsString
        
        // Attribute the pronouciation in hiragana/katakana
        let kanaString = kanjiUpdatedList.kun_readings.joined(separator:", ")
        cell?.kanaLabel.text = kanaString
        
        // Switch
        cell?.kanjiSwitch.tag = indexPath.row
        cell?.kanjiSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        return cell!
    }
    

    
    // Switch method
    @objc func switchChanged(_ sender : UISwitch!){

        // Call method to take kani from filetred list if filter is active
        attributeKanjiFromCorrectList(row: sender.tag)
        
        // Check status of switch
        if sender .isOn {
            //Append listActivatedKAnji
            listActivatedKAnji.append(kanjiUpdatedList)
            CardCreator.cardCreator.listActivatedKAnji.append(kanjiUpdatedList)
            print(listActivatedKAnji)
            
        } else {
            //Remove from listActivatedKAnji
            if let index = listActivatedKAnji.firstIndex(of: kanjiUpdatedList) {
                listActivatedKAnji.remove(at: index)
            }
            if let index = CardCreator.cardCreator.listActivatedKAnji.firstIndex(of: kanjiUpdatedList) {
                CardCreator.cardCreator.listActivatedKAnji.remove(at: index)
            }
            print(listActivatedKAnji)
            
        }
    }
    
    
    
    // MARK: TableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if filtering
        var kanjiUpdatedList: Kanji
          if isFiltering {
            kanjiUpdatedList = filteredKanji[indexPath.row]
          } else {
            kanjiUpdatedList = listKanji[indexPath.row]
          }
        
        // attribute the data
        let detailledKanji = kanjiUpdatedList
        
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
}

// MARK: Extension for search bar
extension KanjiTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}


