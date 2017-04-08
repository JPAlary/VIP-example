//
//  NSLocalizedTranslator.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation

final class NSLocalizedStringTranslator: Translator {

    // MARK: Translator

    func translation(for key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
}
