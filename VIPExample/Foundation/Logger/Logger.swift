//
//  Logger.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 14/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation

protocol Logger {
    func log(level: LoggerLevel, message: Any)
}
