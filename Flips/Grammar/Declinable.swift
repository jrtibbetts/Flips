//  Created by Jason R Tibbetts on 1/31/21.

import Foundation

public enum Case: String {

    case dative
    case genitive
    case nominative
    case vocative

}

public enum Declension: String {

    case first
    case second
    case third
    case fourth
    case fifth

    init(intValue: Int16) {
        switch intValue {
        case 1:
            self = .first
        case 2:
            self = .second
        case 3:
            self = .third
        case 4:
            self = .fourth
        default:
            self = .fifth
        }
    }

}

public enum Gender: String {

    case feminine
    case masculine
    case none

    init(abbreviation: String) {
        switch abbreviation.lowercased() {
        case "f":
            self = .feminine
        case "m":
            self = .masculine
        default:
            self = .none
        }

    }

}
