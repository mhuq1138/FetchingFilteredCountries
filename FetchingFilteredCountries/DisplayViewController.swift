//
//  DisplayViewController.swift
//  FetchRequestInFourWays
//
//  Created by Mazharul Huq on 2/24/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit
import CoreData

class DisplayViewController: UITableViewController {
    
    @IBOutlet var headerLabel: UILabel!
    
    var coreDataStack:CoreDataStack!
    
    var fetchOption = 0
    var countries:[Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.coreDataStack = CoreDataStack(modelName: "CountryList")
    
        self.tableView.rowHeight = 70.0
    
        let fetchRequest:NSFetchRequest<Country> = Country.fetchRequest()
        if let predicate = getPredicate(fetchOption){
            fetchRequest.predicate = predicate
            self.headerLabel.text = String(describing: predicate)
        }
        do{
            countries = try coreDataStack.managedContext.fetch(fetchRequest)
        }
        catch
            let nserror  as NSError{
                print("Could not save \(nserror),(nserror.userInfo)")
        }
    }
    
    
    func getPredicate(_ option:Int)-> NSPredicate?{
        var predicate:NSPredicate?
        switch option{
        case 0:
            predicate = NSPredicate(format: "capital beginswith %@", "D")
        case 1:
            predicate = NSPredicate(format: "%K contains[c] %@","name", "a")
        case 2:
            predicate = NSPredicate(format: "%K <  %i",
                                        #keyPath(Country.area), 90000)
        case 3:
            predicate = NSPredicate(format: "population > %i", 250)
        case 4:
            predicate = NSPredicate(format: "%K contains %@ and %K > %i",#keyPath(Country.name), "a",#keyPath(Country.population), 100)
        case 5:
            let first = NSPredicate(format: "area > %i", 60000)
            let second = NSPredicate(format: "population < %i", 80)
            predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [first,second])
        default:
            break
        }
        return predicate
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = countries[indexPath.row]
        var nameString = ""
        var capitalString = ""
        
        if let name = country.name{
            nameString = name
        }
        if let capital = country.capital{
            capitalString = "Capital: \(capital)"
        }

        cell.textLabel?.text = nameString + " " + capitalString
        cell.detailTextLabel?.text = """
        Area: \(country.area) sq mi
        Population: \(country.population) millions
        """
        return cell
    }
}
