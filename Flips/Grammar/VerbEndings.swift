//  Created by Jason R Tibbetts on 10/12/20.

import Foundation

public extension Verb {

    enum Conjugation: String, Codable {
        case first
        case second
    }

    enum Mood: String, Codable {
        case conditional
        case imperative
        case indicative
        case subjunctive
    }

    enum Number: String, Codable {
        case singular
        case plural
    }

    enum Person: String, Codable {
        case first
        case second
        case third
//        case relative
//        case autonomous
    }

    enum RootVowel: String, Codable {
        case broad
        case slender

        static func value(for vowel: String?) -> RootVowel {
            switch vowel?.lowercased() {
            case "a", "o", "u":
                return .broad
            case "e", "i":
                return .slender
            default:
                return .broad
            }
        }
    }

    enum Tense: String, Codable {
        case present
        case past
        case pastHabitual = "past habitual"
        case future
    }

    enum Voice: String, Codable {
        case active
        case middle
        case passive
    }

}
