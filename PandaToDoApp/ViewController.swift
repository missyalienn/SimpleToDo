//
//  ViewController.swift
//  PandaToDoApp
//
//  Created by Missy Allan on 2/28/17.
//  Copyright © 2017 PandaLabs. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var todos = [Task]()
    let store = DataStore.sharedInstance
//    var tasks = [Task]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   
    //MARK: TableView Data Source 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell")
        cell?.backgroundColor = UIColor.yellow
        if let unwrappedTitle = self.todos[indexPath.row].title {
            cell?.textLabel?.text = todos[indexPath.row].title
        }
    
        return cell!
    }

    
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Task", message: "Add Task", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            
            self.saveToDo(titleString: nameToSave)
            //rself.todos.append(nameToSave)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    func saveToDo(titleString: String) {
        let managedContext = store.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)
        
        if let unwrappedEntity = entity {
            var todo = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Task
            todo.title = titleString
            do {
                try managedContext.save()
                self.todos.append(todo)
            }catch{
                
                print("Error saving task")
            }
        }
    }


    
    
    
}

