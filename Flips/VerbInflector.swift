//  Created by Jason R Tibbetts on 10/14/20.

import Foundation

public struct VerbInflection {

    var particle: String?
    var prefix: String?
    var root: String = ""
    var ending: String = ""
    var pronoun: String?

}

public protocol VerbInflector {

    var tense: Verb.Tense? { get }
    var mood: Verb.Mood { get }

    func inflect(verb: Verb,
                 person: Verb.Person,
                 number: Verb.Number) -> VerbInflection

}

public extension VerbInflector {

    func pronoun(_ person: Verb.Person, _ number: Verb.Number) -> String {
        switch (person, number) {
        case (.first, .singular):
            return "mé"
        case (.second, .singular):
            return "tú"
        case (.third, .singular):
            return "sé/sí"
        case (.first, .plural):
            return "muid"
        case (.second, .plural):
            return "sibh"
        case (.third, .plural):
            return "siad"
        }
    }

}

public struct FirstConjugationSlenderPresentIndicativeActive: VerbInflector {

    public var tense: Verb.Tense? = .present

    public var mood = Verb.Mood.indicative

    public func inflect(verb: Verb, person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root ?? "")
        inflection.pronoun = pronoun(person, number)

        switch (person, number) {
        case (.first, .singular):
            inflection.ending = "im"
        case (.first, .plural):
            inflection.ending = "imid"
        default:
            inflection.ending = "eann"
        }

        return inflection
    }

}

public struct FirstConjugationSlenderPresentIndicativePast: VerbInflector {

    public var tense: Verb.Tense? = .present

    public var mood = Verb.Mood.indicative

    public func inflect(verb: Verb, person: Verb.Person, number: Verb.Number) -> VerbInflection {
        return VerbInflection(root: verb.root ?? "",
                              pronoun: pronoun(person, number))
    }

}
