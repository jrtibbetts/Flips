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

public enum VerbMode: String, CaseIterable {

    case positive = "Positive"
    case negative = "Ní"
    case interrogative = "An"
    case negativeInterrogative = "Nach"

    static var allValues: [VerbMode] = [.positive, .negative, .interrogative, .negativeInterrogative]

    func forTense(_ tense: Verb.Tense) -> String? {
        switch tense {
        case .present, .future:
            switch self {
            case .positive:
                return nil
            case .negative:
                return "ní"
            case .interrogative:
                return "an"
            case .negativeInterrogative:
                return "nach"
            }
        case .past, .pastHabitual:
            switch self {
            case .positive:
                return nil
            case .negative:
                return "níor"
            case .interrogative:
                return "ar"
            case .negativeInterrogative:
                return "nár"
            }
        }
    }
}

/// Produces inflected forms of a verb in a particular tense and mood.
open class VerbInflector: NSObject, ObservableObject {

    @Published open var mode: VerbMode
    @Published open var mood: Verb.Mood
    @Published open var tense: Verb.Tense?
    @Published open var translation: String?
    @Published open var verb: Verb

    public init(verb: Verb,
                mode: VerbMode,
                mood: Verb.Mood,
                tense: Verb.Tense? = nil,
                translation: String? = "") {
        self.verb = verb
        self.mode = mode
        self.mood = mood
        self.tense = tense
        self.translation = translation
        super.init()
    }

    open func inflect(person: Verb.Person,
                 number: Verb.Number) -> VerbInflection? {
        return nil
    }

    open var displayName: String {
        if let capitalizedTense = tense?.rawValue.capitalized {
            return "\(mood.rawValue.capitalized) \(capitalizedTense)"
        } else {
            return mood.rawValue.capitalized
        }
    }

    open func englishPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String {
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

    open func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
        if let translation = translation {
            return "\(englishPronoun(person, number)) \(translation)"
        } else {
            return nil
        }
    }

    open func pronoun(_ person: Verb.Person, _ number: Verb.Number) -> String {
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

public class FirstConjugationPresentIndicative: VerbInflector {

    public init(verb: Verb, mode: VerbMode) {
        super.init(verb: verb, mode: mode, mood: .indicative, tense: .present, translation: verb.englishPresent)
    }

    public override func translationWithPronoun(_ person: Verb.Person, _ number: Verb.Number) -> String? {
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

    public override func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        guard let root = verb.root,
              let conjugation = Verb.Conjugation(rawValue: verb.conjugation) else {
            return VerbInflection()
        }

        var inflection = VerbInflection()

        switch mode {
        case .negative,
             .negativeInterrogative:
            inflection.root = root.lenited
        case .interrogative:
            inflection.root = root.eclipsed
        default:
            inflection.root = root
        }

        inflection.particle = mode.forTense(.present)
        inflection.translation = translationWithPronoun(person, number)

        if conjugation == .first {
            switch (person, number) {
            case (.first, .singular):
                inflection.ending = verb.isSlender ? "im" : "aim"
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "imid" : "aimid"
            default:
                inflection.ending = verb.isSlender ? "eann" : "ann"
            }
        } else {
            switch (person, number) {
            case (.first, .singular):
                inflection.ending = verb.isSlender ? "ím" : "aím"
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "ímid" : "aímid"
            default:
                inflection.ending = verb.isSlender ? "íonn" : "aíonn"
            }
        }

        if person != .first {
            inflection.pronoun = pronoun(person, number)
        }

        return inflection
    }

}

public class FirstConjugationPastIndicative: VerbInflector {

    public init(verb: Verb, mode: VerbMode) {
        super.init(verb: verb, mode: mode, mood: .indicative, tense: .past, translation: verb.englishPast)
    }

    public override func translationWithPronoun(_ person: Verb.Person,
                                                _ number: Verb.Number) -> String? {
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

    public override func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        guard var root = verb.irregularPastRoot ?? verb.root,
              let conjugation = Verb.Conjugation(rawValue: verb.conjugation) else {
            return VerbInflection()
        }

        root = root.lenited

        var inflection = VerbInflection(root: root)
        inflection.translation = translationWithPronoun(person, number)

        if verb.startsWithVowel && (mode == .positive || mode == .interrogative) {
            inflection.prefix = "d'"
        }

        if conjugation == .first {
            switch (person, number) {
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "eamar" : "amar"
            default:
                inflection.pronoun = pronoun(person, number)
            }
        } else {
            switch (person, number) {
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "íomar" : "aíomar"
            default:
                inflection.pronoun = pronoun(person, number)
            }
        }

        inflection.particle = mode.forTense(.past)

        return inflection
    }

}

public class FirstConjugationImperfect: VerbInflector {

    public init(verb: Verb, mode: VerbMode) {
        super.init(verb: verb, mode: mode, mood: .indicative, tense: .pastHabitual)

        if let translation = verb.englishPresent {
            self.translation = "used to \(translation)"
        }
    }

    public override func translationWithPronoun(_ person: Verb.Person,
                                                _ number: Verb.Number) -> String? {
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

    public override func inflect(person: Verb.Person, number: Verb.Number) -> VerbInflection {
        guard let root = verb.root,
              let conjugation = Verb.Conjugation(rawValue: verb.conjugation) else {
            return VerbInflection()
        }

        var inflection = VerbInflection(root: root.lenited)
        inflection.translation = translationWithPronoun(person, number)

        if verb.startsWithVowel {
            inflection.prefix = "d'"
        }

        if conjugation == .first {
            switch (person, number) {
            case (.first, .singular):
                inflection.ending = verb.isSlender ? "inn" : "ainn"
            case (.second, .singular):
                if let pastParticiple = verb.pastParticiple {
                    if pastParticiple.last == "h" {
                        inflection.root = String(pastParticiple.dropLast())
                    }

                    inflection.ending = verb.isSlender ? "teá" : "tá"
                }
            case (.third, .singular),
                 (.second, .plural):
                inflection.ending = verb.isSlender ? "eadh" : "adh"
                inflection.pronoun = pronoun(person, number)
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "imis" : "aimis"
            case (.third, .plural):
                inflection.ending = verb.isSlender ? "idís" : "aidís"
                inflection.pronoun = pronoun(person, number)
            }
        } else {
            switch (person, number) {
            case (.first, .singular):
                inflection.ending = verb.isSlender ? "ínn" : "aínn"
            case (.second, .singular):
                inflection.ending = verb.isSlender ? "ítéa" : "aítéa"
            case (.third, .singular),
                (.second, .plural):
                inflection.ending = verb.isSlender ? "íodh" : "aíodh"
                inflection.pronoun = pronoun(person, number)
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "ímis" : "aímis"
            case (.third, .plural):
                inflection.ending = verb.isSlender ? "ídis" : "aídis"
                inflection.pronoun = pronoun(person, number)
            }
        }

        inflection.particle = mode.forTense(.pastHabitual)

        return inflection
    }

}

public class FirstConjugationFutureIndicative: VerbInflector {

    public init(verb: Verb, mode: VerbMode) {
        super.init(verb: verb, mode: mode, mood: .indicative, tense: .future)

        if let translation = verb.englishPresent {
            self.translation = "will \(translation)"
        }
    }

    public override func translationWithPronoun(_ person: Verb.Person,
                                                _ number: Verb.Number) -> String? {
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

    public override func inflect(person: Verb.Person,
                                 number: Verb.Number) -> VerbInflection {
        guard let root = verb.irregularFutureRoot ?? verb.root,
              let conjugation = Verb.Conjugation(rawValue: verb.conjugation) else {
            return VerbInflection()
        }

        var inflection = VerbInflection(root: root)
        inflection.translation = translationWithPronoun(person, number)

        if conjugation == .first {
            switch (person, number) {
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "fimid" : "faimid"
            // no pronoun
            default:
                inflection.ending = verb.isSlender ? "fidh" : "faidh"
                inflection.pronoun = pronoun(person, number)
            }
        } else {
            switch (person, number) {
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "eoimid" : "oimid"
            // no pronoun
            default:
                inflection.ending = verb.isSlender ? "eoidh" : "oid"
                inflection.pronoun = pronoun(person, number)
            }

        }

        inflection.particle = mode.forTense(.future)

        return inflection
    }

}

public class FirstConjugationConditional: VerbInflector {

    public init(verb: Verb, mode: VerbMode) {
        super.init(verb: verb, mode: mode, mood: .conditional)

        if let translation = verb.englishPresent {
            self.translation = "would \(translation)"
        }
    }

    public override func translationWithPronoun(_ person: Verb.Person,
                                                _ number: Verb.Number) -> String? {
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

    public override func inflect(person: Verb.Person,
                                 number: Verb.Number) -> VerbInflection {
        guard let root = verb.root,
              let conjugation = Verb.Conjugation(rawValue: verb.conjugation) else {
            return VerbInflection()
        }

        var inflection = VerbInflection(root: root)
        inflection.translation = translationWithPronoun(person, number)

        if verb.startsWithVowel {
            inflection.prefix = "d'"
        }

        if conjugation == .first {
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
                inflection.ending = verb.isSlender ? "fimis" : "faimis"
            case (.third, .plural):
                inflection.ending = verb.isSlender ? "fidís" : "faidís"
            }
        } else {
            switch (person, number) {
            case (.first, .singular):
                inflection.ending = verb.isSlender ? "eoinn" : "oinn"
            case (.second, .singular):
                inflection.ending = verb.isSlender ? "eofá" : "ofá"
            case (.third, .singular),
                 (.second, .plural):
                inflection.ending = verb.isSlender ? "eodh" : "odh"
                inflection.pronoun = pronoun(person, number)
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "eoimis" : "oimis"
            case (.third, .plural):
                inflection.ending = verb.isSlender ? "eoidís" : "oidís"
            }
        }

        switch mode {
        case .interrogative:
            inflection.particle = "dá"
        case .negative:
            inflection.particle = "mura"
        default:
            inflection.particle = nil
        }

        return inflection
    }

}

public class FirstConjugationPresentSubjunctive: VerbInflector {

    public init(verb: Verb, mode: VerbMode) {
        super.init(verb: verb, mode: mode, mood: .subjunctive, tense: .present)

        if let translation = verb.englishPresent {
            self.translation = "could \(translation)"
        }
    }

    public override func translationWithPronoun(_ person: Verb.Person,
                                                _ number: Verb.Number) -> String? {
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

    public override func inflect(person: Verb.Person,
                                 number: Verb.Number) -> VerbInflection {
        guard let root = verb.root,
              let conjugation = Verb.Conjugation(rawValue: verb.conjugation) else {
            return VerbInflection()
        }

        var inflection = VerbInflection(root: root)
        inflection.translation = translationWithPronoun(person, number)
        inflection.particle = "go"

        if verb.startsWithVowel {
            inflection.prefix = "n-"
        }

        if conjugation == .first {
            switch (person, number) {
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "imid" : "aimid"
            default:
                inflection.ending = verb.isSlender ? "e" : "a"
                inflection.pronoun = pronoun(person, number)
            }
        } else {
            switch (person, number) {
            case (.first, .plural):
                inflection.ending = verb.isSlender ? "ímid" : "aímid"
            default:
                inflection.ending = verb.isSlender ? "i" : "aí"
                inflection.pronoun = pronoun(person, number)
            }
        }

        inflection.particle = mode.forTense(.present)

        return inflection
    }

}

public class FirstConjugationPastSubjunctive: VerbInflector {

    public init(verb: Verb, mode: VerbMode) {
        super.init(verb: verb, mode: mode, mood: .subjunctive, tense: .past)

        if let translation = verb.englishPastParticiple {
            self.translation = "could have \(translation)"
        }
    }

    public override func translationWithPronoun(_ person: Verb.Person,
                                                _ number: Verb.Number) -> String? {
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
            return "\(pronoun) couldn't have \(englishPastParticiple)"
        case .negativeInterrogative:
            return "couldn't \(pronoun) have \(englishPastParticiple)?"
        }
    }

    public override func inflect(person: Verb.Person,
                                 number: Verb.Number) -> VerbInflection {
        let pastHabitualInflector = FirstConjugationImperfect(verb: verb,
                                                              mode: mode)
        var inflection = pastHabitualInflector.inflect(person: person, number: number)
        inflection.root = inflection.root.eclipsed
        inflection.translation = translationWithPronoun(person, number)
        inflection.particle = "dá"

        if verb.startsWithVowel {
            inflection.prefix = "n-"
        }

        inflection.particle = mode.forTense(.past)

        return inflection
    }

}
