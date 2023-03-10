//
//  Mark.swift
//  Activities
//
//  Created by Roman Gorbenko on 17/02/23.
//

import Foundation

enum Mark: Int, Codable, CaseIterable {
    case tooBad = -3
    case bad = -2
    case normal = 0
    case good = 1
    case excelent = 2
}
