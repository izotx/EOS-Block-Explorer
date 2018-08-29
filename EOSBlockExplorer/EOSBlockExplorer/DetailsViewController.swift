//
//  ViewController.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/28/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import UIKit






class DetailsViewController: UIViewController, UITableViewDelegate {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var singature: UILabel!
    @IBOutlet weak var transactionsLabel: UILabel!
    @IBOutlet weak var transactionDetailsSwitch: UISwitch!
    
    //Current Block Data
    private var block:Block?
   
    
    func updateBlockInfo(_block:Block){
        self.block = _block
    }
    
    func showBlockDetails(visible:Bool){
        self.textView.isHidden = !visible
    }
    
    //Responsible for basic updates of UI
    func updateUI(){
        self.textView.text = block?.content_string
        self.producerLabel.text = block?.producer
        self.singature.text = block?.producer_signature
        if let transactions = block?.transactions{
                    self.transactionsLabel.text =  "\(transactions.count)"
        }else{
              self.transactionsLabel.text = "0"
        }
        showBlockDetails(visible: transactionDetailsSwitch.isOn)
    }
    
    @IBAction func showTransactionSwitchAction(_ sender: UISwitch) {
        showBlockDetails(visible: sender.isOn)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

//Testing with local data
//        if let b = loadLocalData()
//        {
//            updateBlockInfo(_block: b)
//        }
        
        updateUI()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailsViewController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
}


extension DetailsViewController{
    //Just for testing purposes
    func loadLocalData()->Block?{
        let blockops = BlockchainOperations()
        let urlpath     = Bundle.main.path(forResource: "block_info", ofType: "json")
        let url         = NSURL.fileURL(withPath: urlpath!)
        let blockData = try? Data(contentsOf: url)
        guard let data = blockData else{
            print("data doesn't exist!")
            //Throw Error here!
            return nil
        }
        
        guard let block = blockops.decodeJSONBlockData(data) else{
            print("Wrong data format")
            //Throw Error here!
            return nil
        }
        return block
    }
}



