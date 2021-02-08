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

public struct Ag: InflectedPreposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "ag " + declinedNoun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "agam"
        case (.singular, .second, _):
            return "agat"
        case (.singular, .third, .masculine):
            return "aige"
        case (.singular, .third, .feminine):
            return "aici"
        case (.plural, .first, _):
            return "againn"
        case (.plural, .second, _):
            return "agaibh"
        case (.plural, .third, _):
            return "acu"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "agamsa"
        case (.singular, .second, _):
            return "agatsa"
        case (.singular, .third, .masculine):
            return "aigesean"
        case (.singular, .third, .feminine):
            return "aicise"
        case (.plural, .first, _):
            return "againne"
        case (.plural, .second, _):
            return "abaibhse"
        case (.plural, .third, _):
            return "acusan"
        default:
            return nil
        }
    }

}

public struct Ar: InflectedPreposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "ar " + declinedNoun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "orm"
        case (.singular, .second, _):
            return "ort"
        case (.singular, .third, .masculine):
            return "air"
        case (.singular, .third, .feminine):
            return "uirthi"
        case (.plural, .first, _):
            return "orainn"
        case (.plural, .second, _):
            return "oraibh"
        case (.plural, .third, _):
            return "orthu"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "ormsa"
        case (.singular, .second, _):
            return "ortsa"
        case (.singular, .third, .masculine):
            return "airsean"
        case (.singular, .third, .feminine):
            return "uirthise"
        case (.plural, .first, _):
            return "orainne"
        case (.plural, .second, _):
            return "oraibhe"
        case (.plural, .third, _):
            return "orthusan"
        default:
            return nil
        }
    }

}

public struct As: InflectedPreposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "as " + declinedNoun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "asam"
        case (.singular, .second, _):
            return "asat"
        case (.singular, .third, .masculine):
            return "as"
        case (.singular, .third, .feminine):
            return "aisti"
        case (.plural, .first, _):
            return "asainn"
        case (.plural, .second, _):
            return "asaibh"
        case (.plural, .third, _):
            return "astu"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "asamsa"
        case (.singular, .second, _):
            return "asatsa"
        case (.singular, .third, .masculine):
            return "as-san"
        case (.singular, .third, .feminine):
            return "aistise"
        case (.plural, .first, _):
            return "asainne"
        case (.plural, .second, _):
            return "asaibhse"
        case (.plural, .third, _):
            return "astusan"
        default:
            return nil
        }
    }

}

public struct Chuig: InflectedPreposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "chuig " + declinedNoun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "chugam"
        case (.singular, .second, _):
            return "chugat"
        case (.singular, .third, .masculine):
            return "chuige"
        case (.singular, .third, .feminine):
            return "chuici"
        case (.plural, .first, _):
            return "chugainn"
        case (.plural, .second, _):
            return "chugaibh"
        case (.plural, .third, _):
            return "chucu"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Verb.Number, person: Verb.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "chugamsa"
        case (.singular, .second, _):
            return "chugatsa"
        case (.singular, .third, .masculine):
            return "chuigsean"
        case (.singular, .third, .feminine):
            return "chuicise"
        case (.plural, .first, _):
            return "chugainne"
        case (.plural, .second, _):
            return "chugaibhse"
        case (.plural, .third, _):
            return "chucusan"
        default:
            return nil
        }
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
