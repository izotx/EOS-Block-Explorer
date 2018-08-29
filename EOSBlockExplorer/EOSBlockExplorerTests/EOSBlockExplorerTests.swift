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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let urlpath     = Bundle.main.path(forResource: "block_info", ofType: "json")
        let url         = NSURL.fileURL(withPath: urlpath!)
        blockData = try? Data(contentsOf: url)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testParsingBlockData(){
        let blockops = BlockchainOperations()
        guard let data = blockData else{
            //Throw Error here!
            return
        }

//        XCTAssertNotNil(blockData,"Block file data corrupted?")
        guard let block = blockops.decodeJSONBlockData(data) else{
            //Throw Error here!
            return
        }

//        XCTAssertNotNil(block,"Block data corrupted?")
       
        
    }
    
    func testParsingChainData(){
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
