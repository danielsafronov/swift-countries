//
//  Nework.swift
//  Countries
//
//  Created by Daniel Safronov on 27.07.2021.
//

import Foundation

enum NetworkStatusCode: Int {
    case ok = 200
}

enum NetworkError: Error {
    case clientError
}
