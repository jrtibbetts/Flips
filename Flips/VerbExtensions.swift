//
//  VerbExtensions.swift
//  Flips
//
//  Created by Jason R Tibbetts on 10/15/20.
//

import Foundation

public extension Verb {

    var isSlender: Bool {
        guard let rootVowel = self.rootVowel?.lowercased() else {
            return false
        }

        switch rootVowel {
        case "a", "á", "o", "ó", "u", "ú":
            return false
        default:
            return true
        }
    }

    var startsWithVowel: Bool {
        guard let firstLetter = self.root?.first?.lowercased() else {
            return false
        }

        switch firstLetter {
        case "a", "á", "e", "é", "i", "í", "o", "ó", "u", "ú":
            return true
        default:
            return false
        }
    }

}
