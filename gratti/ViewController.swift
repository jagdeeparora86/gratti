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
    
    let defaults = UserDefaults.standard;
    let currencyFormatter = NumberFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDefualtTip();
        setObservers();
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true);
        
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let tipPercent = [0.15, 0.18, 0.20];
        let bill = Double(billField.text!) ?? 0.0;
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        currencyFormatter.numberStyle = NumberFormatter.Style.currency;
        currencyFormatter.locale = Locale.current
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip));
        currencyFormatter.string(from: NSNumber(value: tip))
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDefualtTip(){
        if(defaults.object(forKey: "defaultTip") != nil){
            tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTip");
            calculateTip(tipControl);
        }
    }
    
     func applicationBecameActive(_ notification: Notification){
        print("inside application became active")
        if(defaults.object(forKey: "previousAccess") != nil)
        {
            print("previousAccess is there");
            let pt = defaults.object(forKey: "previousAccess") as! Date
            let interval = NSInteger(Date().timeIntervalSince(pt))
            let minutes = (interval / 60) % 60
            print(" INTERVAL IS" )
            print(minutes)
            if(minutes < 2)
            {
                billField.text = (defaults.object(forKey: "lastBillAmount") as! String)
                tipControl.selectedSegmentIndex = defaults.integer(forKey: "lastTip")
                calculateTip(tipControl)
            }
            else
            {
                billField.text = "0.0"
                calculateTip(tipControl)
            }
        }
        
    }
    
    func applicationBecameInActive(_ notification: Notification){
        print("APP IS NOW IN BACKGROUND")
        defaults.set(Date(), forKey: "previousAccess")
        print(billField.text)
        
        defaults.set(billField.text, forKey: "lastBillAmount")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "lastTip")
        
    }
    
    func setObservers(){
        //Adding a delay time found a bug acc to which if in ios 9 the UIApplicationDidBecomeActiveNotification
        // observer won't work, the work around is to add a delay in the call.
        
        
        let delayInSeconds = 0.5
        let delayTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
            self.initialNotificationReceiver()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.applicationBecameInActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)

    }
    
    func initialNotificationReceiver(){
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.applicationBecameActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

}

