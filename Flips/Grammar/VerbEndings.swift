//  Created by Jason R Tibbetts on 10/12/20.

import Foundation

public extension Verb {

    enum Declension: String {
        case first
        case second
    }

    enum Vowel: String {
        case broad
        case slender
    }

    enum Syllables: String {
        case single
        case doubleOrMore
    }

    enum Mood: String {
        case conditional
        case imperative
        case indicative
        case subjunctive
    }

    enum Number: String {
        case singular
        case plural
    }

    enum Person: String {
        case first
        case second
        case third
        case relative
        case autonomous
    }

    enum Tense: String {
        case present
        case past
        case pastHabitual = "past habitual"
        case future
    }

    struct Ending: Hashable {

        var person: Person
        var number: Number?
        var tense: Tense?
        var mood: Mood
        var voice: Voice?
        var declension: Declension
        var syllables: Syllables
        var vowel: Vowel

    }

    enum Voice: String {
        case active
        case middle
        case passive
    }

    static var endings: [Ending: String] = {
        return [
            Ending(person: .first,  number: .singular, tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender): "im",
            Ending(person: .second, number: .singular, tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender): "eann",
            Ending(person: .third,  number: .singular, tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender): "eann",
            Ending(person: .first,  number: .plural,   tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender): "imid",
            Ending(person: .second, number: .plural,   tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender): "eann",
            Ending(person: .third,  number: .plural,   tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender): "eann"
        ]
    }()
}
