//
//  FetchOptionViewController.swift
//  FetchRequestInFourWays
//
//  Created by Mazharul Huq on 2/24/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit

class FilterViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.tableView.rowHeight = 80.0
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 5
        }
        else{
            return 1
        }
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "displayViewController") as! DisplayViewController
        if indexPath.section == 0{
            vc.fetchOption = indexPath.row
        }
        else{
            vc.fetchOption = 5
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
