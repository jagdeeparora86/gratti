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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(defaults.object(forKey: "defaultTip") != nil){
            defaultTipSegment.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
        }

    }
    @IBAction func updateDefaultTip(_ sender: AnyObject) {
        
        defaults.set(defaultTipSegment.selectedSegmentIndex, forKey: "defaultTip")
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
