//
//  Response.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation

protocol Response {
    var succeed: Bool { get }
    var data: Data? { get }
    var error: Error? { get }
    var statusCode: HTTPStatusCode? { get }
    var request: URLRequest { get }
    var headers: [String: Any]? { get }
}
