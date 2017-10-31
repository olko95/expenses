//
//  CategoryDetailViewController.swift
//  Expenses App
//
//  Created by Nadiia Pavliuk on 27.10.17.
//  Copyright © 2017 Nadiia Pavliuk. All rights reserved.
//

import UIKit
import CoreData
class CategoryDetailViewController: UIViewController {

        
        var category: NSManagedObject? = nil
        var isDeleted: Bool = false
        var indexPath: IndexPath? = nil
        
    @IBOutlet weak var switchController: UISegmentedControl!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            categoryNameLabel.text = category?.value(forKey:"categoryName") as? String
            priceLabel.text = category?.value(forKey:"price") as? String
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        @IBOutlet weak var categoryNameLabel: UILabel!
        @IBOutlet weak var priceLabel: UILabel!
        
        @IBAction func done(_ sender: Any) {
            performSegue(withIdentifier: "unwindToCategoryList", sender: self)
        }
    
    
        
    @IBAction func changePrice(_ sender: AnyObject) {

        if switchController.selectedSegmentIndex == 0 {
           // priceLabel.text =  "+$ "
            priceLabel.textColor = UIColor.blue
        }
        if switchController.selectedSegmentIndex == 1 {
           // priceLabel.text =  "-$ "
            priceLabel.textColor = UIColor.red
        }
        
        
    }
    @IBAction func deleteCategory(_ sender: Any) {
            isDeleted = true
            performSegue(withIdentifier: "unwindToCategoryList", sender: self)
        }
        
        //MARK: - Navigation
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "editCategory" {
                guard let viewController = segue.destination as? AddCategoryViewController else { return }
                viewController.titleText = "Edit Category"
                viewController.category = category
                viewController.indexPathForCategory = self.indexPath!
            }
        }
        
}

