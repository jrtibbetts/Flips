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

public extension String {

    var eclipsed: String {
        guard let firstLetter = self.first?.lowercased() else {
            return self
        }

        switch firstLetter {
        case "b":
            return "m\(self)"
        case "c":
            return "g\(self)"
        case "d":
            return "n\(self)"
        case "f":
            return "bh\(self)"
        case "g":
            return "n\(self)"
        case "p":
            return "p\(self)"
        case "t":
            return "d\(self)"
        case "a", "á", "e", "é", "i", "í", "o", "ó", "u", "ú":
            return "n-\(self)"
        default:
            return self
        }
    }

    var lenited: String {
        guard let firstLetter = self.first else {
            return self
        }

        let theRest = self.dropFirst()

        switch firstLetter {
        case "b", "c", "d", "f", "g", "m", "p", "s", "t":
            return "\(firstLetter)h\(theRest)"
        default:
            return self
        }
    }

}
