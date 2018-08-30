//
//  ViewController.swift
//  RicardianApp
//
//  Created by Janusz Chudzynski on 8/29/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    let ri = RicardianOperations()
    
    @IBOutlet weak var textView: UITextView!
  
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func readContractAction(_ sender: Any) {
        textView.text = ""
        guard let txt = self.textField.text, txt.count > 0 else{
            textView.text = "Please Specify the Transaction Id"
            return
        }
    ri.getContractsForTransaction(txt).done{contracts in

        let texts = contracts.flatMap({return $0})
        for c in texts{
            self.textView.text.append(c)
        }
            //display contracts
            }.catch{ error in
                self.textView.text = error.localizedDescription
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        // Do any additional setup after loading the view, typically from a nib.
     
        //b23bee6920aa96799b932eb42573e80a9b4872eb8128ccdd5acebd231be80e05
        //3852750abc7a2e1b4b5176a89c7f29f327ab97c96ba3bd12ff655b0451fe989c
        //WORKING c8235df76accabf854b4a0c16af17e7418497f7d72265bf7de5abc18a19125e3
        
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

