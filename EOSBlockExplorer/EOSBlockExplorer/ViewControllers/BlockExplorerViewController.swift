//
//  BlockExplorerViewController.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/28/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import UIKit


class BlockExplorerViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var blockchainops:BlockchainOperations!
    private var datasource = BlocksDataSource()
    private var currentBlock:Block?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setup table view
        self.blockchainops = BlockchainOperations()


        //Setup TableView and Register the cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIds.BlockCell.rawValue)
        tableView.dataSource = datasource
        tableView.delegate = self

        //Setup UI
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshBlocksAction(_:)) )
        navigationItem.rightBarButtonItem = refreshItem
        self.title =  "EOS Block Explorer"
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func presentAlert(text:String){
        let alert = UIAlertController(title: "Message", message:text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc @IBAction func refreshBlocksAction(_ sender: Any) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //Avoiding Retain Cycle using weak self
        self.blockchainops.downloadBlocks(20) { [weak self] (blocks, error) in

            //A lot of networking calls, switch it to the Main Thread
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let error = error{
                    //present error to the user
                    self?.presentAlert(text: error.localizedDescription)
                }
                
                self?.datasource.blocks = blocks
                self?.tableView.reloadData()
            }
        }
    }
    


    // MARK: - Navigation
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
}


//Delegate methods
extension BlockExplorerViewController{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //get current block
        let block = self.datasource.blocks[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.updateBlockInfo(_block: block)
        navigationController?.pushViewController(vc, animated: true)
    }
}



class BlocksDataSource: NSObject, UITableViewDataSource{
    
    var blocks = [Block]()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let block = blocks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.BlockCell.rawValue, for: indexPath as IndexPath)
        if indexPath.row == 0{
            cell.backgroundColor = UIColor.gray
            cell.textLabel?.textColor = UIColor.white
        }
        else{
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.darkGray

        }
        cell.textLabel?.text = String(block.block_num)
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: "tag")
            
        return cell
    }
    
}
