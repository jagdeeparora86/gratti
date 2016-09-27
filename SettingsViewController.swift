//
//  SettingsViewController.swift
//  gratti
//
//  Created by Singh, Jagdeep on 9/26/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipSegment: UISegmentedControl!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(defaults.objectForKey("defaultTip") != nil){
            defaultTipSegment.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        }

    }
    @IBAction func updateDefaultTip(sender: AnyObject) {
        
        defaults.setInteger(defaultTipSegment.selectedSegmentIndex, forKey: "defaultTip")
        defaults.synchronize();
        
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
