//
//  EOSBlockExplorerTests.swift
//  EOSBlockExplorerTests
//
//  Created by Janusz Local Admin on 8/28/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import XCTest
@testable import EOSBlockExplorer

class EOSBlockExplorerTests: XCTestCase {
    var blockData:Data?
    var chainData:Data?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let urlpath     = Bundle.main.path(forResource: "block_info", ofType: "json")
        let url         = NSURL.fileURL(withPath: urlpath!)
        blockData = try? Data(contentsOf: url)
        
        let urlpath1     = Bundle.main.path(forResource: "chain_info", ofType: "json")
        let url1         = NSURL.fileURL(withPath: urlpath1!)
        chainData = try? Data(contentsOf: url1)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParsingBlockData(){
        let blockops = BlockchainOperations()
        guard let data = blockData else{
            XCTAssert(false, "Something went wrong with getting the data. Data malformed?")
            //Throw Error here!
            return
        }

        guard let block = blockops.decodeJSONBlockData(data) else{
            XCTAssert(false, "Something went wrong with decoding JSON")
             return
        }
        
        
        XCTAssert(block.producer == "eoslaomaocom", "Block Producer should be diferent!")
        XCTAssert(block.block_num == 13363637, "Block Number should be diferent!")
        XCTAssert(block.producer_signature == "SIG_K1_K9JKkPZ9jVn1ZfpAhgQrsyLRe6pJ7X9rEUsETvShWDQTgyiseHtPX3NwdmM6evAiGaeZ6cQxiMM43HSY2Xak8hfcjLvYWi", "Block Signature should be diferent!")
        XCTAssert(block.transactions.count == 128)
    }
    
    func testParsingChainData(){
        let blockops = BlockchainOperations()
        guard let data = chainData else{
            XCTAssert(false, "Something went wrong with getting the data. Data malformed?")
            //Throw Error here!
            return
        }
        
        guard let chain = blockops.decodeJSONChainData(data) else{
            XCTAssert(false, "Something went wrong with decoding JSON")
            return
        }
        
       
        XCTAssert(chain.lastBlock == 13367671, "Block should be diferent!")
    }

    
    func testMalformedJSON(){
        let urlpath     = Bundle.main.path(forResource: "malformed_block", ofType: "json")
        let url         = NSURL.fileURL(withPath: urlpath!)
        blockData = try? Data(contentsOf: url)
        let blockops = BlockchainOperations()
        guard let data = blockData else{
            XCTAssert(false, "Something went wrong with getting the data. Data malformed?")
            //Throw Error here!
            return
        }
        
       let block = blockops.decodeJSONBlockData(data)
       XCTAssertNil(block, "Block should be nil")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
