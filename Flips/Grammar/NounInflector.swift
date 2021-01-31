//  Created by Jason R Tibbetts on 1/31/21.

import Foundation

public enum Case: String {

    case accusative
    case dative
    case genitive
    case nominative

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

public class NounInflector: NSObject, ObservableObject {

    @Published open var declension: Declension
    @Published open var gender: Gender
    @Published open var noun: Noun
    @Published open var translation: String?

    public init(noun: Noun,
                gender: Gender,
                declension: Declension,
                translation: String? = nil) {
        self.noun = noun
        self.gender = gender
        self.declension = declension
        self.translation = translation
        super.init()
    }

    convenience init(noun: Noun,
                     gender: String,
                     declension: Int16,
                     translation: String? = nil) {
        self.init(noun: noun,
        gender: Gender(abbreviation: gender),
        declension: Declension(intValue: declension),
        translation: translation)
    }

    open func inflect(case: Case, number: Verb.Number) -> String? {
        return nil
    }

    open var displayName: String {
        return declension.rawValue.uppercased() + " " + gender.rawValue.uppercased()
    }

}

