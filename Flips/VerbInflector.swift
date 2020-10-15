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

    var verb: Verb { get }
    var tense: Verb.Tense? { get }
    var mood: Verb.Mood { get }

    func inflect(person: Verb.Person,
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

public struct FirstConjugationSlenderPresentIndicative: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .present

    public var mood = Verb.Mood.indicative

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
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

public struct FirstConjugationSlenderPastIndicative: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .past

    public var mood = Verb.Mood.indicative

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        return VerbInflection(root: verb.root ?? "",
                              pronoun: pronoun(person, number))
    }

}

public struct FirstConjugationSlenderPastHabitualIndicative: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .pastHabitual

    public var mood = Verb.Mood.indicative

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root ?? "")

        switch (person, number) {
        case (.first, .singular):
            inflection.ending = "inn"
        case (.second, .singular):
            inflection.ending = (verb.pastParticiple ?? "") + "á" // is this correct?
        case (.third, .singular),
             (.second, .plural):
            inflection.ending = "eadh"
            inflection.pronoun = pronoun(person, number)
        case (.first, .plural):
            inflection.ending = "imid"
        case (.third, .plural):
            inflection.ending = "idís"
            inflection.pronoun = pronoun(person, number)
        }

        return inflection
    }

}

public struct FirstConjugationSlenderFutureIndicative: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .future

    public var mood = Verb.Mood.indicative

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root ?? "")

        switch (person, number) {
        case (.first, .plural):
            inflection.ending = "fimid"
        // no pronoun
        default:
            inflection.ending = "fidh"
            inflection.pronoun = pronoun(person, number)
        }

        return inflection
    }
}

public struct FirstConjugationSlenderConditional: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = Verb.Tense.none

    public var mood = Verb.Mood.conditional

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root ?? "")

        switch (person, number) {
        case (.first, .singular):
            inflection.ending = "finn"
        case (.second, .singular):
            inflection.ending = "feá"
        case (.third, .singular),
             (.second, .plural):
            inflection.ending = "feadh"
            inflection.pronoun = pronoun(person, number)
        case (.first, .plural):
            inflection.ending = "fimid"
        case (.third, .plural):
            inflection.ending = "fidís"
        }

        return inflection
    }
}
