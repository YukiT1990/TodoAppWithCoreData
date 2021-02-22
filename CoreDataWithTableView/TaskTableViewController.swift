//
//  TaskTableViewController.swift
//  CoreDataWithTableView
//
//  Created by Yuki Tsukada on 2021/02/22.
//

import UIKit
import CoreData

// MARK: variable definition
var fetchedTasks: [ManagedTask] = []
var container01 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class TaskTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let fetchRequest01 = NSFetchRequest<NSManagedObject>(entityName: "ManagedTask")
        do{
            fetchedTasks = try container01.fetch(fetchRequest01 as! NSFetchRequest<NSFetchRequestResult>) as! [ManagedTask]
            tableView.reloadData()
        } catch {
            print("Fetching Failed")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        let fetchedTask003 = fetchedTasks[indexPath.row]
        cell.nameLabel!.text = fetchedTask003.title
        cell.descriptionLabel!.text = fetchedTask003.todoDescription
        if fetchedTask003.isCompleted == false {
            cell.isCompletedLabel.text = ""
        } else {
            cell.isCompletedLabel.text = "✔️"
        }
        return cell
    }

    @IBAction func unwindToFirstView(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fetchedTask002 = fetchedTasks[indexPath.row]
            fetchedTasks.remove(at: indexPath.row)
            container01.delete(fetchedTask002)
            
            do {
                try container01.save()
            } catch {
                print("Error deleting items with \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fetchedTask004 = fetchedTasks[indexPath.row]
        fetchedTask004.isCompleted.toggle()
        do {
            try container01.save()
        } catch {
            print("Error deleting items with \(error)")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let fetchedTask006 = fetchedTasks[indexPath.row]
        taskToEdit = fetchedTask006
        targetIndexPath = indexPath
    }

}
