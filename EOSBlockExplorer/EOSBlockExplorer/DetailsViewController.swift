//
//  ViewController.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/28/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    //Current Block Data
    var block:Block?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let blockops = BlockchainOperations()
        //Get local data
        

//        blockops.decodeJSONBlockData(<#T##data: Data##Data#>)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

