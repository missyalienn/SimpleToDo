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
        //self.tableView.insertYellowGradient()
        
        tableView.reloadData()
        
  
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        self.tableView.insertYellowGradient()

    }
   
    //MARK: TableView Data Source 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell")
        cell?.backgroundColor = UIColor(red:1.00, green:0.74, blue:0.41, alpha:1.0)

        cell?.textLabel?.textColor = UIColor.white
        if let unwrappedTitle = self.todos[indexPath.row].title {
            cell?.textLabel?.text = todos[indexPath.row].title
            cell?.textLabel?.font = UIFont(name: "Avenir", size: 22.0)
        }
    
        return cell!
    }

   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            self.todos.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
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
    
    
    func fetchData() {
        let managedContext = store.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        do {
            self.todos = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
            
        } catch {
            print("Error fetching data")
            print(error.localizedDescription)
        }
    }
    
    
    
    
    func saveToDo(titleString: String) {
        let managedContext = store.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)
        
        if let unwrappedEntity = entity {
            let todo = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Task
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

// MARK: Gradients


extension CALayer {
    public static func makeGradient(firstColor: UIColor, secondColor: UIColor, thirdColor: UIColor) -> CAGradientLayer {
        let backgroundGradient = CAGradientLayer()
        let firstColor = UIColor(red:1.00, green:0.88, blue:0.33, alpha:1.0).cgColor
        let secondColor = UIColor(red:1.00, green:0.74, blue:0.41, alpha:1.0).cgColor
        let thirdColor = UIColor(red:0.95, green:0.29, blue:0.52, alpha:1.0).cgColor
        backgroundGradient.colors = [firstColor, secondColor, thirdColor]
        backgroundGradient.locations = [0, 1]
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradient.endPoint = CGPoint(x: 0, y: 1)
        
        return backgroundGradient
    }
}



extension UIView {
    func insertYellowGradient() {
        let firstColor = UIColor(red:1.00, green:0.88, blue:0.33, alpha:1.0).cgColor
        let secondColor = UIColor(red:1.00, green:0.74, blue:0.41, alpha:1.0).cgColor
        let thirdColor = UIColor(red:0.95, green:0.29, blue:0.52, alpha:1.0).cgColor
        let gradient: CAGradientLayer
        gradient = CAGradientLayer()
        gradient.colors = [firstColor, secondColor, thirdColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = UIScreen.main.bounds
        self.layer.insertSublayer(gradient, at: 0)

    }
}




