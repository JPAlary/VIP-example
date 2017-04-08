//
//  Deserializable.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation

protocol Deserializable {
    init(data: Data) throws
}

protocol AnyInitializable {
    init(object: Any) throws
}

extension Deserializable where Self: AnyInitializable {
    init(data: Data) throws {
        let object: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

        try self.init(object: object)
    }
}
