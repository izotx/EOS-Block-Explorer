//
//  constants.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/29/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import Foundation

enum EOSError: Error {
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case parsingJSON
    case currentlyDownloading
}

enum CellIds:String{
    case BlockCell = "BlockCell"
    case BlockDetailsCell = "BlockInfoCell"
    case LongTextCell = "LongTextCell"
}



