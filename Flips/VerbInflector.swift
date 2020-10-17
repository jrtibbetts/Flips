//  Created by Jason R Tibbetts on 10/14/20.

import Foundation

/// Holds the components that constitute a verb's inflection in a specific
/// person, number, tense, and mood.
public struct VerbInflection {

    var particle: String?
    var prefix: String?
    var root: String = ""
    var ending: String = ""
    var pronoun: String?
    var translation: String?

}

public enum VerbMode: String {

    case positive = "Positive"
    case negative = "Ní"
    case interrogative = "An"
    case negativeInterrogative = "Nach"

    static var allValues: [VerbMode] = [.positive, .negative, .interrogative, .negativeInterrogative]

}

/// Produces inflected forms of a verb in a particular tense and mood.
public protocol VerbInflector {

    var verb: Verb { get }
    var tense: Verb.Tense? { get }
    var mood: Verb.Mood { get }
    var translation: String? { get }

    func inflect(person: Verb.Person,
                 number: Verb.Number) -> VerbInflection

}

public extension VerbInflector {

    var displayName: String {
        if let capitalizedTense = tense?.rawValue.capitalized {
            return "\(mood.rawValue.capitalized) \(capitalizedTense)"
        } else {
            return mood.rawValue.capitalized
        }
    }

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

    func englishPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String {
        switch (person, number) {
        case (.first, .singular):
            return "I"
        case (.second, .singular):
            return "you"
        case (.third, .singular):
            return "he/she/it"
            case (.first, .plural):
            return "we"
        case (.second, .plural):
            return "you (all)"
        case (.third, .plural):
            return "they"
        }
    }

    func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        if let translation = translation {
            return "\(englishPronoun(person, number)) \(translation)"
        } else {
            return nil
        }
    }

}

public struct FirstConjugationPresentIndicative: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .present

    public var mood = Verb.Mood.indicative

    public var translation: String? {
        return verb.englishPresent
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root ?? "")
        inflection.pronoun = pronoun(person, number)
        inflection.translation = translationWithPronoun(person, number)

        switch (person, number) {
        case (.first, .singular):
            inflection.ending = verb.isSlender ? "im" : "aim"
        case (.first, .plural):
            inflection.ending = verb.isSlender ? "imid" : "aimid"
        default:
            inflection.ending = verb.isSlender ? "eann" : "ann"
        }

        return inflection
    }

}

public struct FirstConjugationPastIndicative: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .past

    public var mood = Verb.Mood.indicative

    public var translation: String? {
        return verb.englishPast
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var root = verb.simplePastRoot ?? verb.root ?? ""
        root = root.lenited

        var inflection = VerbInflection(root: root)
        inflection.translation = translationWithPronoun(person, number)

        if verb.startsWithVowel {
            inflection.prefix = "d'"
        }

        switch (person, number) {
        case (.first, .plural):
            inflection.ending = verb.isSlender ? "eamar" : "amar"
        default:
            inflection.pronoun = pronoun(person, number)
        }

        return inflection
    }

}

public struct FirstConjugationPastHabitualIndicative: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .pastHabitual

    public var mood = Verb.Mood.indicative

    public var translation: String? {
        if let translation = verb.englishPresent {
            return "used to \(translation)"
        } else {
            return nil
        }
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root?.lenited ?? "")
        inflection.translation = translationWithPronoun(person, number)

        if verb.startsWithVowel {
            inflection.prefix = "d'"
        }

        switch (person, number) {
        case (.first, .singular):
            inflection.ending = verb.isSlender ? "inn" : "ainn"
        case (.second, .singular):
            if let pastParticiple = verb.pastParticiple {
                if pastParticiple.last == "h" {
                    inflection.root = String(pastParticiple.dropLast())
                }

                inflection.ending = verb.isSlender ? "eá" : "á"
            }
        case (.third, .singular),
             (.second, .plural):
            inflection.ending = verb.isSlender ? "eadh" : "adh"
            inflection.pronoun = pronoun(person, number)
        case (.first, .plural):
            inflection.ending = verb.isSlender ? "imid" : "aimid"
        case (.third, .plural):
            inflection.ending = verb.isSlender ? "idís" : "aidís"
            inflection.pronoun = pronoun(person, number)
        }

        return inflection
    }

}

public struct FirstConjugationFutureIndicative: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .future

    public var mood = Verb.Mood.indicative

    public var translation: String? {
        if let translation = verb.englishPresent {
            return "will \(translation)"
        } else {
            return nil
        }
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root ?? "")
        inflection.translation = translationWithPronoun(person, number)

        switch (person, number) {
        case (.first, .plural):
            inflection.ending = verb.isSlender ? "fimid" : "faimid"
        // no pronoun
        default:
            inflection.ending = verb.isSlender ? "fidh" : "faidh"
            inflection.pronoun = pronoun(person, number)
        }

        return inflection
    }

}

public struct FirstConjugationConditional: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense?

    public var mood = Verb.Mood.conditional

    public var translation: String? {
        if let translation = verb.englishPresent {
            return "would \(translation)"
        } else {
            return nil
        }
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root ?? "")
        inflection.translation = translationWithPronoun(person, number)

        if verb.startsWithVowel {
            inflection.prefix = "d'"
        }

        switch (person, number) {
        case (.first, .singular):
            inflection.ending = verb.isSlender ? "finn" : "fainn"
        case (.second, .singular):
            inflection.ending = verb.isSlender ? "feá" : "fá"
        case (.third, .singular),
             (.second, .plural):
            inflection.ending = verb.isSlender ? "feadh" : "fadh"
            inflection.pronoun = pronoun(person, number)
        case (.first, .plural):
            inflection.ending = verb.isSlender ? "fimid" : "faimid"
        case (.third, .plural):
            inflection.ending = verb.isSlender ? "fidís" : "faidís"
        }

        return inflection
    }

}

public struct FirstConjugationPresentSubjunctive: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .present

    public var mood = Verb.Mood.subjunctive

    public var translation: String? {
        if let translation = verb.englishPresent {
            return "could \(translation)"
        } else {
            return nil
        }
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        var inflection = VerbInflection(root: verb.root ?? "")
        inflection.translation = translationWithPronoun(person, number)
        inflection.particle = "go"

        if verb.startsWithVowel {
            inflection.prefix = "n-"
        }

        switch (person, number) {
        case (.first, .plural):
            inflection.ending = verb.isSlender ? "imid" : "aimid"
        default:
            inflection.ending = verb.isSlender ? "e" : "a"
            inflection.pronoun = pronoun(person, number)
        }

        return inflection
    }

}

public struct FirstConjugationPastSubjunctive: VerbInflector {

    public var verb: Verb

    public var tense: Verb.Tense? = .past

    public var mood = Verb.Mood.subjunctive

    public var translation: String? {
        if let translation = verb.englishPastParticiple {
            return "could have \(translation)"
        } else {
            return nil
        }
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        let pastHabitualInflector = FirstConjugationPastHabitualIndicative(verb: verb,
                                                                                  tense: .pastHabitual,
                                                                                  mood: .indicative)
        var inflection = pastHabitualInflector.inflect(person: person, number: number)
        inflection.translation = translationWithPronoun(person, number)
        inflection.particle = "dá"

        if verb.startsWithVowel {
            inflection.prefix = "n-"
        }

        return inflection
    }

}
