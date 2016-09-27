//
//  ViewController.swift
//  gratti
//
//  Created by Singh, Jagdeep on 9/25/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [billField .becomeFirstResponder()]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults();
        if(defaults.objectForKey("defaultTip") != nil){
            tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip");
            calculateTip(tipControl);
        }
        
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
        
    }
 
    

    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercent = [0.15, 0.18, 0.20];
        
        let bill = Double(billField.text!) ?? 0;
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2 f", total)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

