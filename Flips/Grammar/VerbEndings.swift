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
        case relative
        case autonomous
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

    enum Syllables: String, Codable {
        case single
        case doubleOrMore

        static func value(for syllableCount: Int16? = 0) -> Syllables {
            return (syllableCount == 1 ? .single : .doubleOrMore)
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

    struct Parts: Codable, Hashable {

        var person: Person
        var number: Number?
        var tense: Tense?
        var mood: Mood
        var voice: Voice?
        var conjugation: Conjugation
        var syllables: Syllables
        var rootVowel: RootVowel

    }

    struct VerbEnding: Codable {

        var parts: Parts
        var ending: String
    }

    static var endings: [Parts: String] = {
        let jsonUrl = Bundle.main.url(forResource: "VerbEndings", withExtension: "json")!

        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            let decoder = JSONDecoder()
            var verbEndings = try decoder.decode([VerbEnding].self, from: jsonData)
            var endings = [Parts: String]()

            for ending in verbEndings {
                endings[ending.parts] = ending.ending
            }

            return endings
        } catch {
            return [:]
        }
    }()
}
