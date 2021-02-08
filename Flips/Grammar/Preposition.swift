//  Created by Jason R Tibbetts on 2/6/21.

import Foundation

public protocol Preposition {

    var governsCase: Case { get }

    func decline(declinedNoun: String) -> String?

//    func declineWithDefiniteArticle(noun: Noun, number: Verb.Number) -> String?
//
//    func declineWithPossessive(noun: Noun, possessive: String, person: Verb.Person, number: Verb.Number) -> String?

}

public protocol InflectedPreposition: Preposition {

    func inflect(number: Verb.Number, person: Verb.Person, gender: Gender) -> String?

    func inflectEmphatic(number: Verb.Number, person: Verb.Person, gender: Gender) -> String?

}

public struct Ag: Preposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "ag " + declinedNoun
    }

}

public struct Ar: Preposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "ar " + declinedNoun
    }

}

public struct Chuig: Preposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "chuig " + declinedNoun
    }

}

public struct Do: Preposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "do " + declinedNoun
    }

}

public struct I: Preposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "i " + declinedNoun
    }

}

public struct Le: InflectedPreposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "le " + declinedNoun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "liom"
        case (.singular, .second, _):
            return "leat"
        case (.singular, .third, .masculine):
            return "leis"
        case (.singular, .third, .feminine):
            return "leí"
        case (.plural, .first, _):
            return "linn"
        case (.plural, .second, _):
            return "libh"
        case (.plural, .third, _):
            return "leo"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "liomsa"
        case (.singular, .second, _):
            return "leatsa"
        case (.singular, .third, .masculine):
            return "leis-sean"
        case (.singular, .third, .feminine):
            return "leíse"
        case (.plural, .first, _):
            return "linne"
        case (.plural, .second, _):
            return "libhse"
        case (.plural, .third, _):
            return "leosan"
        default:
            return nil
        }
    }

}
