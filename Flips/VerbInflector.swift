//  Created by Jason R Tibbetts on 10/14/20.

import Foundation

/// Holds the components that constitute a verb's inflection in a specific
/// person, number, tense, and mood.
public struct VerbInflection {

    var ending: String = ""
    var mode: VerbMode = .positive
    var particle: String?
    var prefix: String?
    var pronoun: String?
    var root: String = ""
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

    var mode: VerbMode { get }
    var mood: Verb.Mood { get }
    var tense: Verb.Tense? { get }
    var translation: String? { get }
    var verb: Verb { get }

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

    public var mode: VerbMode

    public var tense: Verb.Tense? = .present

    public var mood = Verb.Mood.indicative

    public var translation: String? {
        return verb.englishPresent
    }

    public func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        guard let translation = translation else {
            return nil
        }

        let pronoun = self.englishPronoun(person, number)

        switch mode {
        case .positive:
            return "\(pronoun) \(translation)"
        case .interrogative:
            switch (person, number) {
            case (.third, .singular):
                return "does \(pronoun) \(translation)?"
            default:
                return "do \(pronoun) \(translation)?"
            }
        case .negative:
            switch (person, number) {
            case (.third, .singular):
                return "\(pronoun) doesn't \(translation)"
            default:
                return "\(pronoun) don't \(translation)"
            }
        case .negativeInterrogative:
            switch (person, number) {
            case (.third, .singular):
                return "doesn't \(pronoun) \(translation)?"
            default:
                return "don't \(pronoun) \(translation)?"
            }
        }
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        guard let root = verb.root else {
            return VerbInflection()
        }

        var inflection = VerbInflection()

        switch mode {
        case .negative,
             .negativeInterrogative:
            inflection.root = root.lenited
            inflection.particle = mode.rawValue
        case .interrogative:
            inflection.root = root.eclipsed
            inflection.particle = mode.rawValue
        default:
            inflection.root = root
            inflection.particle = ""
        }

        inflection.translation = translationWithPronoun(person, number)

        switch (person, number) {
        case (.first, .singular):
            inflection.ending = verb.isSlender ? "im" : "aim"
        case (.first, .plural):
            inflection.ending = verb.isSlender ? "imid" : "aimid"
        default:
            inflection.ending = verb.isSlender ? "eann" : "ann"
            inflection.pronoun = pronoun(person, number)
        }

        return inflection
    }

}

public struct FirstConjugationPastIndicative: VerbInflector {

    public var verb: Verb

    public var mode: VerbMode

    public var tense: Verb.Tense? = .past

    public var mood = Verb.Mood.indicative

    public var translation: String? {
        return verb.englishPast
    }

    public func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        guard let translation = translation,
              let englishPresent = verb.englishPresent else {
            return nil
        }

        let pronoun = self.englishPronoun(person, number)

        switch mode {
        case .positive:
            return "\(pronoun) \(translation)"
        case .interrogative:
            return "did \(pronoun) \(englishPresent)?"
        case .negative:
            return "\(pronoun) didn't \(englishPresent)"
        case .negativeInterrogative:
            return "didn't \(pronoun) \(englishPresent)?"
        }
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

    public var mode: VerbMode

    public var tense: Verb.Tense? = .pastHabitual

    public var mood = Verb.Mood.indicative

    public var translation: String? {
        if let translation = verb.englishPresent {
            return "used to \(translation)"
        } else {
            return nil
        }
    }

    public func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        guard let translation = translation,
              let englishPresent = verb.englishPresent else {
            return nil
        }

        let pronoun = self.englishPronoun(person, number)

        switch mode {
        case .positive:
            return "\(pronoun) \(translation)"
        case .interrogative:
            return "did \(pronoun) use to \(englishPresent)?"
        case .negative:
            return "\(pronoun) didn't use to \(englishPresent)"
        case .negativeInterrogative:
            return "didn't \(pronoun) use to \(englishPresent)?"
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

    public var mode: VerbMode

    public var tense: Verb.Tense? = .future

    public var mood = Verb.Mood.indicative

    public var translation: String? {
        if let translation = verb.englishPresent {
            return "will \(translation)"
        } else {
            return nil
        }
    }

    public func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        guard let translation = translation,
              let englishPresent = verb.englishPresent else {
            return nil
        }

        let pronoun = self.englishPronoun(person, number)

        switch mode {
        case .positive:
            return "\(pronoun) \(translation)"
        case .interrogative:
            return "will \(pronoun) \(englishPresent)?"
        case .negative:
            return "\(pronoun) won't \(englishPresent)"
        case .negativeInterrogative:
            return "won't \(pronoun) \(englishPresent)?"
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

    public var mode: VerbMode

    public var tense: Verb.Tense?

    public var mood = Verb.Mood.conditional

    public var translation: String? {
        if let translation = verb.englishPresent {
            return "would \(translation)"
        } else {
            return nil
        }
    }

    public func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        guard let translation = translation,
              let englishPresent = verb.englishPresent else {
            return nil
        }

        let pronoun = self.englishPronoun(person, number)

        switch mode {
        case .positive:
            return "\(pronoun) \(translation)"
        case .interrogative:
            return "would \(pronoun) \(englishPresent)?"
        case .negative:
            return "\(pronoun) wouldn't \(englishPresent)"
        case .negativeInterrogative:
            return "wouldn't \(pronoun) \(englishPresent)?"
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

    public var mode: VerbMode

    public var tense: Verb.Tense? = .present

    public var mood = Verb.Mood.subjunctive

    public var translation: String? {
        if let translation = verb.englishPresent {
            return "could \(translation)"
        } else {
            return nil
        }
    }

    public func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        guard let translation = translation,
              let englishPresent = verb.englishPresent else {
            return nil
        }

        let pronoun = self.englishPronoun(person, number)

        switch mode {
        case .positive:
            return "\(pronoun) \(translation)"
        case .interrogative:
            return "could \(pronoun) \(englishPresent)?"
        case .negative:
            return "\(pronoun) couldn't \(englishPresent)"
        case .negativeInterrogative:
            return "couldn't \(pronoun) \(englishPresent)?"
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

    public var mode: VerbMode

    public var tense: Verb.Tense? = .past

    public var mood = Verb.Mood.subjunctive

    public var translation: String? {
        if let translation = verb.englishPastParticiple {
            return "could have \(translation)"
        } else {
            return nil
        }
    }

    public func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        guard let translation = translation,
              let englishPastParticiple = verb.englishPastParticiple else {
            return nil
        }

        let pronoun = self.englishPronoun(person, number)

        switch mode {
        case .positive:
            return "\(pronoun) \(translation)"
        case .interrogative:
            return "could \(pronoun) have \(englishPastParticiple)?"
        case .negative:
            return "\(pronoun) could not have \(englishPastParticiple)"
        case .negativeInterrogative:
            return "could \(pronoun) not have \(englishPastParticiple)?"
        }
    }

    public func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        let pastHabitualInflector = FirstConjugationPastHabitualIndicative(verb: verb,
                                                                           mode: mode,
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
