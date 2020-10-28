//  Created by Jason R Tibbetts on 10/12/20.

import Foundation

public extension Verb {

    enum Conjugation: Int16, Codable, CaseIterable {
        case first = 1
        case second = 2
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
