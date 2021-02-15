//
//  KanjiTableViewController.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 15/11/2020.
//

import UIKit
import CoreData

class KanjiTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // Outlet of the table view
    @IBOutlet weak var kanjiTableView: UITableView!
    
    // Outlet to display the number of kanji
    @IBOutlet weak var numberOfKanji: UILabel!
    
    // Outlet for the button to show only selected Kanji
    @IBOutlet weak var showSelectedKanjiButtonOutlet: UIButton!
    
    // Kanji list to be reloaded outside the main queue
    var listKanji = [Kanji]() {
        didSet {
            DispatchQueue.main.async {
                // Reload table view when object is uplaoded
                self.kanjiTableView.reloadData()
                // Load activated Kanji from CoreData
                self.fillKanjiActivatedList()
                // Duplicate this list to have access ti the details from the Stat Table View
                Stats.stats.listOfAllKanji = self.listKanji
            }
        }
    }
    
    // To pass data to the detailled view
    var kanjiDetailData: Kanji?
    
    //Instance of json decoder
    var decoder = KanjiJsonDecoder(session: URLSession(configuration: .default))
    
    // Search bar
    let searchBar = UISearchBar()
    
    // List of kanji filtered by the search bar
    var filteredKanji: [Kanji] = []
    
    // Search bar is empty
    var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    // Search is filetring
    var isFiltering: Bool {
        return !isSearchBarEmpty
    }
    
    // Boolean to see if button of selected kanji display is active or not
    var displaySelectedKanji = false
    
    // Parameter used to attribute filteredKanji array or listActivatedKAnji
    var kanjiFromThisCell: Kanji!
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call the decode methed
        decode()
        
        //Search bar
        setSearchBar()
        searchBar.delegate = self
        
        // Activate the alarm
        Alarm.alarm.chargeAlarmParameters()
        Alarm.alarm.setAllAlarms()
        
        //Dismiss the keyboard
        kanjiTableView.keyboardDismissMode = .onDrag
        
        //Change icon in text for showSelectedButton if iOS<13
        changeShowSelectedButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Change text color in search bar
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
    }
    
    //MARK: Decode the json
    func decode(){
        // Call the decode method
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
    }
    
    
    // MARK: Filtering method
    // Method to create the search bar
    func setSearchBar(){
        // Set its delegate to self
        searchBar.delegate = self
        
        // Position it in the navigation bar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Change attributes
        searchBar.placeholder = "Search English translation"
        searchBar.tintColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
        
    }
    
    // Search bar methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Show cancel button only starting to type
        searchBar.showsCancelButton = true
        
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
    
    // Cancel button on search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Clear the text in the search bar
        searchBar.text = ""
        
        // Hide the cancel button
        searchBar.showsCancelButton = false
        
        // Dismiss the keyboard
        searchBar.endEditing(true)
        
        // realod tableview
        kanjiTableView.reloadData()
    }
    
    // Search button from the search bar to dismiss the key board
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    // Button to show only selected Kanji
    @IBAction func displayOnlySelectedKanji(_ sender: Any) {
        // If no kanji selected
        if CardCreator.cardCreator.listActivatedKAnji == [] {
            numberOfKanji.text = "No Kanji selected"
        }
        
        if !displaySelectedKanji {
            displaySelectedKanji = true
            changeColorOfShowSelectedButton()
        } else {
            displaySelectedKanji = false
            changeColorOfShowSelectedButton()
        }
        
        kanjiTableView.reloadData()
        
    }
    
    // Method to show 
    func changeColorOfShowSelectedButton(){
        if showSelectedKanjiButtonOutlet.tintColor == #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1) {
            showSelectedKanjiButtonOutlet.tintColor = #colorLiteral(red: 0.639534235, green: 0.7437759042, blue: 0.7769008875, alpha: 1)
        } else {
            showSelectedKanjiButtonOutlet.tintColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
        }
    }
    
    // Method to change the logo of button if iOS <13
    func changeShowSelectedButton() {
        // Hide button id iOS 13 or more
        if #available(iOS 13, *) {
            // Do nothing
        } else {
            showSelectedKanjiButtonOutlet.setTitle("( O)", for: .normal)
        }
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KanjiCell", for: indexPath) as? KanjiTableViewCell else {
            return UITableViewCell()
        }
        
        // Call method to take kanji from filetred list if filter is active
        attributeKanjiFromCorrectList(row: indexPath.row)
        
        // Compare list of activated kanji with actual kanji to activate switch for reusable cell
        if CardCreator.cardCreator.listActivatedKAnji.contains(kanjiFromThisCell) {
            cell.kanjiSwitch.isOn = true
        }
        
        // Change switch color if iOS < 13
        if #available(iOS 13, *) {
            //Do nothing
        } else {
            cell.kanjiSwitch.tintColor = #colorLiteral(red: 0.276517272, green: 0.2243287563, blue: 0.4410637617, alpha: 1)
            cell.kanjiSwitch.thumbTintColor = #colorLiteral(red: 0.819682493, green: 0.7896436244, blue: 0.7576106854, alpha: 1)
        }
        
        // Attribute Kanji
        cell.kanjiLabel.text = kanjiFromThisCell.kanji
        
        // Attribute the english translation
        let meaningsString = kanjiFromThisCell.meanings.joined(separator:", ")
        cell.englishLabel.text = meaningsString
        
        // Attribute the pronouciation in hiragana/katakana
        let kanaString = kanjiFromThisCell.kun_readings.joined(separator:", ")
        cell.kanaLabel.text = kanaString
        
        // Switch
        cell.kanjiSwitch.tag = indexPath.row
        cell.kanjiSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        return cell
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
                // Save Kanji in database
                KanjiSaveManagement.kanjiSaveManagement.saveKanji(kanjiName: kanjiFromThisCell.kanji)

            } else {
                //Remove from listActivatedKAnji
                if let index = CardCreator.cardCreator.listActivatedKAnji.firstIndex(of: kanjiFromThisCell) {
                    CardCreator.cardCreator.listActivatedKAnji.remove(at: index)
                }
                // Remove from database
                KanjiSaveManagement.kanjiSaveManagement.removeKanji(kanjiName: kanjiFromThisCell.kanji)
                
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
    
    // MARK: Database Methods
    
    // Method to charge data from database
    private func fillKanjiActivatedList() {
        
        for i in KanjiEntity.all {
            
            // Search in list Kanji the kanji object with the kanji
            if let kanjiToAppendIndex = listKanji.firstIndex(where: { $0.kanji == i.kanji }) {
                
                // Append list of activated kanji
                CardCreator.cardCreator.listActivatedKAnji.append(listKanji[kanjiToAppendIndex])
            }
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toKanjiDetail" {
            let detailVC = segue.destination as! KanjiDetailViewController
            detailVC.kanjiDetailData = kanjiDetailData
        }
    }
    
    //Unwid for iOS < 13
    @IBAction func unwindToKanjiTableVC(_ unwindSegue: UIStoryboardSegue) {
    }
    
    
}

// Extension for the alert method
extension UIViewController {
    // Method to call an alert
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

