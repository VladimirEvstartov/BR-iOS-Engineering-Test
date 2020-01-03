//
//  BRError.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 29.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import Foundation

public enum BRError: Error {
    case badURL
    case wrongMIMEType
}

extension BRError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return BRStrings.badUrlError
        case .wrongMIMEType:
            return BRStrings.wrongMIMEType
        }
    }
}
