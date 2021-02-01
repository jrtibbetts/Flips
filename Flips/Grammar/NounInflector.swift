//  Created by Jason R Tibbetts on 1/31/21.

import Foundation

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

    public convenience init(noun: Noun) {
        self.init(noun: noun,
                  gender: Gender(abbreviation: noun.gender ?? Gender.masculine.rawValue),
                  declension: Declension(intValue: noun.declension),
                  translation: noun.englishTranslation)
    }

    open func inflect(grammaticalCase: Case, number: Verb.Number) -> String? {
        if number == .singular {
            switch grammaticalCase {
            case .nominative, .dative:
                return noun.root
            case .vocative:
                return noun.genitive?.lenited
            case .genitive:
                return noun.genitive
            }
        } else {
            switch grammaticalCase {
            case .nominative, .dative:
                return noun.plural
            case .genitive:
                return noun.root
            case .vocative:
                if let root = noun.root {
                    return root.lenited + "a"
                } else {
                    return nil
                }
            }
        }
    }

    open var displayName: String {
        return declension.rawValue.uppercased() + " " + gender.rawValue.uppercased()
    }

}

