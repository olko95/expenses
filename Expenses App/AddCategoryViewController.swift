//
//  AddCategoryViewController.swift
//  Expenses App
//
//  Created by Nadiia Pavliuk on 27.10.17.
//  Copyright © 2017 Nadiia Pavliuk. All rights reserved.
//

import UIKit
import CoreData
class AddCategoryViewController: UIViewController {

    @IBOutlet weak var switchController: UISegmentedControl!
    var titleText = "Add Category"
        var category: NSManagedObject? = nil
        var indexPathForCategory: IndexPath? = nil
    
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            titleLabel.text = titleText
            if let category = self.category {
                categoryNameTextField.text = category.value(forKey: "categoryName") as? String
                priceTextField.text = category.value(forKey: "price") as? String
                
               
            }
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    

        // MARK: - Navigation
    
    
    
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    @IBAction func switchView(_ sender: AnyObject) {
        if switchController.selectedSegmentIndex == 0 {
            priceTextField.text =  "+$"
            priceTextField.textColor = UIColor.blue
        }
        if switchController.selectedSegmentIndex == 1 {
            priceTextField.text =  "-$"
             priceTextField.textColor = UIColor.red
        }
        
        
    }
    
    //========================
    
    
        
    @IBAction func saveAndClose(_ sender: Any) {
            performSegue(withIdentifier: "unwindToCategoryList", sender: self)
        }
    
    @IBAction func close(_ sender: Any) {
            categoryNameTextField.text = nil
            priceTextField.text = nil
            performSegue(withIdentifier: "unwindToCategoryList", sender: self)
        }
        
        
}

