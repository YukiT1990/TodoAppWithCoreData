//
//  EditTableViewController.swift
//  CoreDataWithTableView
//
//  Created by Yuki Tsukada on 2021/02/22.
//

import UIKit
import CoreData

var taskToEdit: ManagedTask?
var targetIndexPath: IndexPath?

class EditTableViewController: UITableViewController {
    
    var task: ManagedTask?
    
    @IBOutlet weak var updateButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = taskToEdit?.title
        descriptionTextField.text = taskToEdit?.todoDescription
        prioritySegmentedControl.selectedSegmentIndex = Int(taskToEdit?.priorityNumber ?? 0)
        
    }

    // MARK: - Table view data source

    @IBAction func updateButtonTapped(_ sender: UIBarButtonItem) {
        let fetchedTask007 = fetchedTasks[targetIndexPath!.row]
        fetchedTask007.title = nameTextField.text
        fetchedTask007.todoDescription = descriptionTextField.text
        fetchedTask007.priorityNumber = Int64(prioritySegmentedControl.selectedSegmentIndex)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            try container01.save()
        } catch {
            print("Error deleting items with \(error)")
        }
        
    }
    

}
