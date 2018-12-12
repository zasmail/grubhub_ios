//
//  RefinementViewController.swift
//  RiderClient
//
//  Created by Zo Asmail on 12/6/18.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit
import InstantSearch

class RefinementViewController: UIViewController, RefinementTableViewDataSource {
    var refinementController: RefinementController!

    override func viewDidLoad() {
        super.viewDidLoad()
        refinementController = RefinementController(table: tableView)
        tableView.dataSource = refinementController
        tableView.delegate = refinementController
        refinementController.tableDataSource = self
        // refinementController.tableDelegate = self
        
        InstantSearch.shared.register(widget: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing facet: String, with count: Int, is refined: Bool) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "refinementCell", for: indexPath)
        
        cell.textLabel?.text = facet
        cell.detailTextLabel?.text = String(count)
        cell.accessoryType = refined ? .checkmark : .none
        
        return cell
    }
    
    @IBOutlet weak var tableView: RefinementTableWidget!
    
}
