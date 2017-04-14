//
//  AppLogger.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 14/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import SwiftyBeaver

struct AppLogger: Logger {
    private let logger: SwiftyBeaver.Type

    // MARK: Initializer

    init() {
        logger = SwiftyBeaver.self

        let console = ConsoleDestination()
        console.asynchronously = false
        console.format = "$DHH:mm:ss.SSS$d $C$L$c - $M"
        logger.addDestination(console)

//        let remote = SBPlatformDestination(
//            appID: "app_id",
//            appSecret: "app_secret",
//            encryptionKey: "encryption_key"
//        )
//        remote.format = "$DHH:mm:ss.SSS$d $C$L$c - $M"
//        logger.addDestination(remote)
    }

    // MARK: Logger

    func log(level: LoggerLevel, message: Any) {
        switch level {
        case .debug:
            logger.debug(message)
        case .verbose:
            logger.verbose(message)
        case .info:
            logger.info(message)
        case .warning:
            logger.warning(message)
        case .error:
            logger.error(message)
        }
    }
}
