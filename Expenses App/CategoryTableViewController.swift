//
//  CategoryTableViewController.swift
//  Expenses App
//
//  Created by Nadiia Pavliuk on 27.10.17.
//  Copyright © 2017 Nadiia Pavliuk. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    
    var categories: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Data Source
    
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Category")
        do {
            categories = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    
    func save(categoryName: String, price: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName:"Category", in: managedObjectContext) else { return }
        let category = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        category.setValue(categoryName, forKey: "categoryName")
        category.setValue(price, forKey: "price")
        do {
            try managedObjectContext.save()
            self.categories.append(category)
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
    
    func update(indexPath: IndexPath, categoryName:String, price: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let category = categories[indexPath.row]
        category.setValue(categoryName, forKey:"categoryName")
        category.setValue(price, forKey: "price")
        do {
            try managedObjectContext.save()
            categories[indexPath.row] = category
        } catch let error as NSError {
            print("Couldn't update. \(error)")
        }
    }
    
    func delete(_ category: NSManagedObject, at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(category)
        categories.remove(at: indexPath.row)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.value(forKey:"categoryName") as? String
        cell.detailTextLabel?.text = category.value(forKey:"price") as? String
        
        return cell
    }
    
    //MARK: - Navigation
    
    //Unwind segue
    
    
    
    @IBAction func unwindToCategoryList(segue: UIStoryboardSegue) {
        if let viewController = segue.source as? AddCategoryViewController {
            guard let categoryName: String = viewController.categoryNameTextField.text, let price: String = viewController.priceTextField.text else { return }
            if categoryName != "" && price != "" {
                if let indexPath = viewController.indexPathForCategory {
                    update(indexPath: indexPath, categoryName: categoryName, price: price)
                } else {
                    save(categoryName:categoryName, price:price)
                }
            }
            tableView.reloadData()
        } else if let viewController = segue.source as? CategoryDetailViewController {
            if viewController.isDeleted {
                guard let indexPath: IndexPath = viewController.indexPath else { return }
                let category = categories[indexPath.row]
                delete(category, at: indexPath)
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryDetailSegue" {
            guard let navViewController = segue.destination as? UINavigationController else { return }
            guard let viewController = navViewController.topViewController as? CategoryDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let category = categories[indexPath.row]
            viewController.category = category
            viewController.indexPath = indexPath
        }
    }
    
    
    
}

