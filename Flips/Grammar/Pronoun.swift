//  Created by Jason R Tibbetts on 9/24/21.

import Foundation

public enum DefiniteArticle: String {

    case singular = "an"

    case plural = "na"

}

public enum PossessivePronoun: String {

    case firstSingular

    case secondSingular

    case thirdSingularMasculine

    case thirdSingularFeminine

    case firstPlural

    case secondPlural

    case thirdPlural

    var string: String {
        switch self {
        case .firstSingular:
            return "mo"
        case .secondSingular:
            return "do"
        case .firstPlural:
            return "ár"
        case .secondPlural:
            return "bhur"
        default:
            return "a"
        }
    }

    func modify(_ noun: String) -> String {
        switch self {
        case .firstSingular,
                .secondSingular,
                .thirdSingularMasculine:
            return noun.lenited
        case .thirdSingularFeminine:
            return noun
        case .firstPlural,
                .secondPlural,
                .thirdPlural:
            return noun.eclipsed
        }
    }

}
