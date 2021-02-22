//
//  AddTaskTableViewController.swift
//  CoreDataWithTableView
//
//  Created by Yuki Tsukada on 2021/02/22.
//

import UIKit
import CoreData

class AddTaskTableViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    var task: ManagedTask?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source



    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let fetchedTask001 = ManagedTask(context: container01)
        fetchedTask001.title = titleTextField.text
        fetchedTask001.todoDescription = descriptionTextField.text
        fetchedTask001.priorityNumber = Int64(prioritySegmentedControl.selectedSegmentIndex)
        fetchedTask001.isCompleted = false
        
        fetchedTasks.append(fetchedTask001)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            try container01.save()
        } catch {
            print("Error deleting items with \(error)")
        }
        
    }
}
