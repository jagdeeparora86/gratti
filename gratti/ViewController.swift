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
    
    let defaults = NSUserDefaults.standardUserDefaults();
    let currencyFormatter = NSNumberFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setDefualtTip();
        setObservers();
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
        
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercent = [0.15, 0.18, 0.20];
        let bill = Double(billField.text!) ?? 0.0;
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle;
        tipLabel.text = currencyFormatter.stringFromNumber(tip);
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDefualtTip(){
        if(defaults.objectForKey("defaultTip") != nil){
            tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip");
            calculateTip(tipControl);
        }
    }
    
     func applicationBecameActive(notification: NSNotification){
        print("inside application became active")
        if(defaults.objectForKey("previousAccess") != nil)
        {
            print("previousAccess is there");
            let pt = defaults.objectForKey("previousAccess") as! NSDate
            let interval = NSInteger(NSDate().timeIntervalSinceDate(pt))
            let minutes = (interval / 60) % 60
            print(" INTERVAL IS" )
            print(minutes)
            if(minutes < 2)
            {
                billField.text = (defaults.objectForKey("lastBillAmount") as! String)
                tipControl.selectedSegmentIndex = defaults.integerForKey("lastTip")
                calculateTip(tipControl)
            }
            else
            {
                billField.text = "0.0"
                calculateTip(tipControl)
            }
        }
        
    }
    
    func applicationBecameInActive(notification: NSNotification){
        print("APP IS NOW IN BACKGROUND")
        defaults.setObject(NSDate(), forKey: "previousAccess")
        print(billField.text)
        
        defaults.setObject(billField.text, forKey: "lastBillAmount")
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "lastTip")
        
    }
    
    func setObservers(){
        //Adding a delay time found a bug acc to which if in ios 9 the UIApplicationDidBecomeActiveNotification
        // observer won't work, the work around is to add a delay in the call.
        
        
        let delayInSeconds = 0.5
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            self.initialNotificationReceiver()
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("applicationBecameInActive:"), name: UIApplicationWillResignActiveNotification, object: nil)

    }
    
    func initialNotificationReceiver(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationBecameActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }

}

