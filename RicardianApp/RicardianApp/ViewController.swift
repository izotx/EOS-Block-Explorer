//
//  ViewController.swift
//  RicardianApp
//
//  Created by Janusz Chudzynski on 8/29/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ri = RicardianOperations()
        //b23bee6920aa96799b932eb42573e80a9b4872eb8128ccdd5acebd231be80e05
        //3852750abc7a2e1b4b5176a89c7f29f327ab97c96ba3bd12ff655b0451fe989c
        ri.processTransaction("4dff4aa6a12d35220a155263d6df89a604cbc8d0ff0d2ea5142d59f492676e02")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

