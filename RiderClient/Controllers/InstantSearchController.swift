//
//  InstantSearchController.swift
//  RiderClient
//
//  Created by Zo Asmail on 12/6/18.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import Foundation
import UIKit
import InstantSearch

class InstantSearchController: UIViewController, UITableViewDelegate, HitsTableViewDataSource {
    
    var searchController: UISearchController!
    var hitsController: HitsController!

    @IBOutlet weak var topBarView: TopBarView!
    @IBOutlet weak var tableView: HitsTableWidget!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
//        hitsTableView = tableView
        configureSearchController()
        configureTable()
        configureInstantSearch()
        
        hitsController = HitsController(table: tableView)
        tableView.dataSource = hitsController
        tableView.delegate = hitsController
        hitsController.tableDataSource = self
    }
    
    func configureInstantSearch() {
        InstantSearch.shared.registerAllWidgets(in: self.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func configureTable() {
        tableView.delegate = self
        tableView.backgroundColor = ColorConstants.tableColor
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing hit: [String : Any]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! ItemCell
        
        cell.item = ItemRecord(json: hit)
        cell.backgroundColor = ColorConstants.tableColor
        
        return cell
    }
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search items"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.barTintColor = ColorConstants.barBackgroundColor
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.layer.cornerRadius = 1.0
        searchController.searchBar.clipsToBounds = true
//        SearchBarWidget.addSubview(searchController.searchBar)
    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing hit: [String : Any]) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "hitCell", for: indexPath)
//        cell.textLabel?.highlightedTextColor = .blue
//        cell.textLabel?.highlightedBackgroundColor = .yellow
//        cell.textLabel?.highlightedText = SearchResults.highlightResult(hit: hit, path: "dish_name")?.value
//        return cell
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let senderAttribute = sender as! UITableViewCell
//        let reciverVC = segue.destination as! MainViewController
//        reciverVC.params = "test"
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //will be handled later
//    }
    
    
    
    
    
    
    
}
