//
//  TableViewController.swift
//  pogoda
//
//  Created by user on 5/29/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var cityArray = ["Voronezh", "Novosibirsk", "Orel"]
    var cityselect = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        if let defaultsCity = UserDefaults.standard.array(forKey: "cityArray") {
            cityArray = defaultsCity as! [String]
            }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        cell.cityLabel.text = cityArray[indexPath.row]
        cell.cityImage.layer.borderWidth = 1
        cell.cityImage.layer.cornerRadius = 25
        //cell.cityImage.layer.borderColor = UIColor.clear.cgColor
        cell.cityImage.image = UIImage(named: "city")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityselect = cityArray[indexPath.row]
        performSegue(withIdentifier: "toDetailCity", sender: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            cityArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.cityArray, forKey: "cityArray")
            
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailCity" {
            let vcDest = segue.destination as! CityDetailViewController
            vcDest.cityName = cityselect
        }
    }
    

    @IBAction func addCityAction(_ sender: Any) {
        let alert = UIAlertController(title: "Please", message: "Input city", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Example: Perm"
        }
        let ok = UIAlertAction(title: "Add", style: .default) { (okAction) in
            let city = alert.textFields![0].text
            if !city!.isEmpty {
                self.cityArray.append(city!)
                self.tableView.reloadData()
                UserDefaults.standard.set(self.cityArray, forKey: "cityArray")
            }
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
