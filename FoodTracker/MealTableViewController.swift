//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 7/2/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    /*
     ------------------------------------
     MARK: Properties
     ------------------------------------
     */
    // Sets a new Meal Object within the meal variable
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadSampleMeals()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    ------------------------------------
    MARK: - Table view data source
     
    The following methods come with a TableViewController by default as par of its dataSource and delegate protocols
    ------------------------------------
    */
    
    // Setting this method to 1 allows for this tableView to appear in the view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // This returns the total number of rows in dataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        // Sets a constant that will downcast UITableViewCell to MealTableViewCell after being unwrapped. If there is an issue with mapping the MealTableViewCell then log error
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]

        // Configure the cell by attaching the values within the corresponding item in the Meal Object to the views set in MealTableViewCell
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /*
     ------------------------------------
     MARK: Actions
     ------------------------------------
     */
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        // Detects if an instance of Meal is being passed through and assigns it to sourceViewController as if it was being referred to as MealViewController
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            // if a new meal is set, then find the last index in the list of meals and add the new meal to the end of the table view
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    /*
     ------------------------------------
     MARK: Private Methods
     ------------------------------------
     */
    // This is considered a seed of a data model
    private func loadSampleMeals() {
        // load the three images that will be used for the sample data
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to initiate meal1")
        }
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to initiate meal2")
        }
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to initiate meal3")
        }
        
        meals += [meal1, meal2, meal3]
    }
}
