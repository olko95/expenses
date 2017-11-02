//
//  ConverterViewController.swift
//  Expenses App
//
//  Created by Nadiia Pavliuk on 02.11.17.
//  Copyright © 2017 Nadiia Pavliuk. All rights reserved.
//

import UIKit


class ConverterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var myCurrency: [String] = []
    var myValues: [Double] = []
    var activeCurrency: Double = 0
    
    //OBJECTS
    
    //CREATING PICKER VIEW
    
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var output: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
    }
    @IBAction func convertCurrency(_ sender: UIButton) {
        if (input.text != "") {
            output.text = String(Double(input.text!)! / activeCurrency)
        }
    }
    @IBAction func backconverter(_ sender: UIButton) {
        performSegue(withIdentifier: "backconverter", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //GETTING DATA
        let url = URL(string: "http://api.fixer.io/latest?base=USD")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key, value) in rates
                            {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                                self.pickerView.reloadAllComponents()
                                
                            }
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
            
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


