//  Created by Jason R Tibbetts on 2/6/21.

import Foundation

public protocol Preposition {

    var governsCase: Case { get }

    func decline(declinedNoun: String) -> String?

//    func declineWithDefiniteArticle(noun: Noun, number: Verb.Number) -> String?
//
//    func declineWithPossessive(noun: Noun, possessive: String, person: Verb.Person, number: Verb.Number) -> String?

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

public struct Le: Preposition {

    public var governsCase = Case.dative

    public func decline(declinedNoun: String) -> String? {
        return "le " + declinedNoun
    }

}
