//  Created by Jason R Tibbetts on 2/6/21.

import Foundation

public protocol Preposition {

    var englishTranslation: String { get }

    var governsCase: Case { get }

    var string: String { get }

    func decline(_ noun: String) -> String?

//    func declineWithDefiniteArticle(noun: Noun, number: Grammar.Number) -> String?
//
//    func declineWithPossessive(noun: Noun, possessive: String, person: Grammar.Person, number: Grammar.Number) -> String?

}

public protocol InflectedPreposition: Preposition {

    func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String?

    func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String?

}

public protocol ContractingPreposition: Preposition {

    func contractedWith(_ definiteArticle: DefiniteArticle) -> String

    func contractedWith(_ possessive: PossessivePronoun) -> String

}

public struct Ag: InflectedPreposition {

    public var englishTranslation = "at"

    public var governsCase = Case.dative

    public var string = "ag"

    public func decline(_ noun: String) -> String? {
        return "ag " + noun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

    public var englishTranslation = "on"

    public var string = "ar"

    public var governsCase = Case.dative

    public func decline(_ noun: String) -> String? {
        return "ar " + noun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

    public var englishTranslation = "out of"

    public var string = "as"

    public var governsCase = Case.dative

    public func decline(_ noun: String) -> String? {
        return "as " + noun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

    public var englishTranslation = "toward"

    public var string = "chuig"

    public var governsCase = Case.dative

    public func decline(_ noun: String) -> String? {
        return "chuig " + noun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

public struct De: ContractingPreposition, InflectedPreposition {

    public var englishTranslation = "from"

    public var string = "de"

    public var governsCase = Case.dative

    public func contractedWith(_ definiteArticle: DefiniteArticle) -> String {
        return (definiteArticle == .singular ? "don" : "\(self.string) \(definiteArticle.rawValue)")
    }

    public func contractedWith(_ possessive: PossessivePronoun) -> String {
        switch possessive {
        case .thirdSingularMasculine,
                .thirdSingularFeminine,
                .thirdPlural:
            return "dá"
        case .firstPlural:
            return "dár"
        default:
            return "\(self.string) \(possessive.string)"
        }
    }

    public func decline(_ noun: String) -> String? {
        return "de " + noun.lenited
    }

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "díom"
        case (.singular, .second, _):
            return "díot"
        case (.singular, .third, .masculine):
            return "de"
        case (.singular, .third, .feminine):
            return "di"
        case (.plural, .first, _):
            return "dínn"
        case (.plural, .second, _):
            return "díbh"
        case (.plural, .third, _):
            return "díobh"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "díomsa"
        case (.singular, .second, _):
            return "díotsa"
        case (.singular, .third, .masculine):
            return "desean"
        case (.singular, .third, .feminine):
            return "dise"
        case (.plural, .first, _):
            return "dínne"
        case (.plural, .second, _):
            return "díbhe"
        case (.plural, .third, _):
            return "díobhsan"
        default:
            return nil
        }
    }

}

public struct Do: InflectedPreposition, ContractingPreposition {

    public var englishTranslation = "to, for"

    public var string = "do"

    public var governsCase = Case.dative

    public func contractedWith(_ definiteArticle: DefiniteArticle) -> String {
        return (definiteArticle == .singular ? "don" : "\(self.string) \(definiteArticle.rawValue)")
    }

    public func contractedWith(_ possessive: PossessivePronoun) -> String {
        switch possessive {
        case .thirdSingularMasculine,
                .thirdSingularFeminine,
                .thirdPlural:
            return "dá"
        case .firstPlural:
            return "dár"
        default:
            return "\(self.string) \(possessive.string)"
        }
    }

    public func decline(_ noun: String) -> String? {
        return "do " + noun.lenited
    }

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "dom"
        case (.singular, .second, _):
            return "duit"
        case (.singular, .third, .masculine):
            return "dó"
        case (.singular, .third, .feminine):
            return "di"
        case (.plural, .first, _):
            return "dúinn"
        case (.plural, .second, _):
            return "daoibh"
        case (.plural, .third, _):
            return "dóibh"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "domsa"
        case (.singular, .second, _):
            return "duitse"
        case (.singular, .third, .masculine):
            return "dósan"
        case (.singular, .third, .feminine):
            return "dise"
        case (.plural, .first, _):
            return "dúinne"
        case (.plural, .second, _):
            return "daoibhse"
        case (.plural, .third, _):
            return "dóibhsean"
        default:
            return nil
        }
    }

}

public struct Faoi: InflectedPreposition, ContractingPreposition {

    public var englishTranslation = "about"

    public var string = "faoi"

    public var governsCase = Case.dative

    public func contractedWith(_ definiteArticle: DefiniteArticle) -> String {
        return (definiteArticle == .singular ? "faoin" : "\(self.string) \(definiteArticle.rawValue)")
    }

    public func contractedWith(_ possessive: PossessivePronoun) -> String {
        switch possessive {
        case .thirdSingularMasculine,
                .thirdSingularFeminine,
                .thirdPlural:
            return "faoina"
        case .firstPlural:
            return "faoinár"
        default:
            return "\(self.string) \(possessive.string)"
        }
    }

    public func decline(_ noun: String) -> String? {
        return "faoi " + noun
    }

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "fúm"
        case (.singular, .second, _):
            return "fút"
        case (.singular, .third, .masculine):
            return "faoi"
        case (.singular, .third, .feminine):
            return "fúithi"
        case (.plural, .first, _):
            return "fúinn"
        case (.plural, .second, _):
            return "fúibh"
        case (.plural, .third, _):
            return "fúthu"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "fúmsa"
        case (.singular, .second, _):
            return "fútsa"
        case (.singular, .third, .masculine):
            return "faoisean"
        case (.singular, .third, .feminine):
            return "fúithise"
        case (.plural, .first, _):
            return "fúinne"
        case (.plural, .second, _):
            return "fúibhse"
        case (.plural, .third, _):
            return "fúthusean"
        default:
            return nil
        }
    }

}

public struct Fara: InflectedPreposition, ContractingPreposition {

    public var englishTranslation = "alongside"

    public var string = "fara"

    public var governsCase = Case.dative

    public func contractedWith(_ definiteArticle: DefiniteArticle) -> String {
        return "fairis \(definiteArticle.rawValue)"
    }

    public func contractedWith(_ possessive: PossessivePronoun) -> String {
        switch possessive {
        case .thirdSingularMasculine,
                .thirdSingularFeminine,
                .thirdPlural:
            return "farana"
        case .firstPlural:
            return "faranár"
        default:
            return "\(self.string) \(possessive.string)"
        }
    }

    public func decline(_ noun: String) -> String? {
        return "fara " + noun
    }

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "faram"
        case (.singular, .second, _):
            return "farat"
        case (.singular, .third, .masculine):
            return "fairis"
        case (.singular, .third, .feminine):
            return "farae"
        case (.plural, .first, _):
            return "farainn"
        case (.plural, .second, _):
            return "faraibh"
        case (.plural, .third, _):
            return "faru"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "faramsa"
        case (.singular, .second, _):
            return "faratsa"
        case (.singular, .third, .masculine):
            return "fairis-sean"
        case (.singular, .third, .feminine):
            return "faraese"
        case (.plural, .first, _):
            return "farainne"
        case (.plural, .second, _):
            return "faraibse"
        case (.plural, .third, _):
            return "farusan"
        default:
            return nil
        }
    }

}

public struct I: Preposition, ContractingPreposition {

    public var englishTranslation = "in"

    public var string = "i"

    public var governsCase = Case.dative

    public func contractedWith(_ definiteArticle: DefiniteArticle) -> String {
        return (definiteArticle == .singular ? "sa(n)" : "sna")
    }

    public func contractedWith(_ possessive: PossessivePronoun) -> String {
        switch possessive {
        case .thirdSingularMasculine,
                .thirdSingularFeminine,
                .thirdPlural:
            return "ina"
        case .firstPlural:
            return "inár"
        default:
            return "\(self.string) \(possessive.string)"
        }
    }

    public func decline(_ noun: String) -> String? {
        return "i " + noun
    }

}

public struct Le: InflectedPreposition, ContractingPreposition {

    public var englishTranslation = "with"

    public var string = "le"

    public var governsCase = Case.dative

    public func contractedWith(_ definiteArticle: DefiniteArticle) -> String {
        return "leis \(definiteArticle.rawValue)"
    }

    public func contractedWith(_ possessive: PossessivePronoun) -> String {
        switch possessive {
        case .thirdSingularMasculine,
                .thirdSingularFeminine,
                .thirdPlural:
            return "lena"
        case .firstPlural:
            return "lenár"
        default:
            return "\(self.string) \(possessive.string)"
        }
    }

    public func decline(_ noun: String) -> String? {
        return "le " + noun
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
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

public struct Ó: InflectedPreposition, ContractingPreposition {

    public var englishTranslation = "from, since"

    public var string = "ó"

    public var governsCase = Case.dative

    public func contractedWith(_ definiteArticle: DefiniteArticle) -> String {
        return (definiteArticle == .singular ? "ón" : "\(self.string) \(definiteArticle.rawValue)")
    }

    public func contractedWith(_ possessive: PossessivePronoun) -> String {
        switch possessive {
        case .thirdSingularMasculine,
                .thirdSingularFeminine,
                .thirdPlural:
            return "óna"
        case .firstPlural:
            return "ónár"
        default:
            return "\(self.string) \(possessive.string)"
        }
    }

    public func decline(_ noun: String) -> String? {
        return "ó " + noun.lenited
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "uaim"
        case (.singular, .second, _):
            return "uait"
        case (.singular, .third, .masculine):
            return "uaidh"
        case (.singular, .third, .feminine):
            return "uaithi"
        case (.plural, .first, _):
            return "uainn"
        case (.plural, .second, _):
            return "uaibh"
        case (.plural, .third, _):
            return "uathu"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "uaimsa"
        case (.singular, .second, _):
            return "uaitsa"
        case (.singular, .third, .masculine):
            return "uaidhsean"
        case (.singular, .third, .feminine):
            return "uaithise"
        case (.plural, .first, _):
            return "uainne"
        case (.plural, .second, _):
            return "uaibhse"
        case (.plural, .third, _):
            return "uathusan"
        default:
            return nil
        }
    }

}

public struct Trí: InflectedPreposition, ContractingPreposition {

    public var englishTranslation = "through"

    public var string = "trí"

    public var governsCase = Case.dative

    public func contractedWith(_ definiteArticle: DefiniteArticle) -> String {
        return (definiteArticle == .singular ? "trid an": "\(self.string) \(definiteArticle.rawValue)")
    }

    public func contractedWith(_ possessive: PossessivePronoun) -> String {
        switch possessive {
        case .thirdSingularMasculine,
                .thirdSingularFeminine,
                .thirdPlural:
            return "tríná"
        case .firstPlural:
            return "trínár"
        default:
            return "\(self.string) \(possessive.string)"
        }
    }

    public func decline(_ noun: String) -> String? {
        return "trí " + noun.lenited
    }

    // MARK: - InflectedPreposition

    public func inflect(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "tríom"
        case (.singular, .second, _):
            return "tríot"
        case (.singular, .third, .masculine):
            return "tríd"
        case (.singular, .third, .feminine):
            return "tríthi"
        case (.plural, .first, _):
            return "trínn"
        case (.plural, .second, _):
            return "tríbh"
        case (.plural, .third, _):
            return "tríothu"
        default:
            return nil
        }
    }

    public func inflectEmphatic(number: Grammar.Number, person: Grammar.Person, gender: Gender) -> String? {
        switch (number, person, gender) {
        case (.singular, .first, _):
            return "tríomsa"
        case (.singular, .second, _):
            return "tríotsa"
        case (.singular, .third, .masculine):
            return "trídsean"
        case (.singular, .third, .feminine):
            return "trínne"
        case (.plural, .first, _):
            return "tríbhse"
        case (.plural, .second, _):
            return "tríothusan"
        case (.plural, .third, _):
            return "uathusan"
        default:
            return nil
        }
    }

}
