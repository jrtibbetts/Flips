//  Created by Jason R Tibbetts on 1/31/21.

import Foundation

public class NounInflector: NSObject, ObservableObject {

    @Published open var declension: Declension
    @Published open var gender: Gender
    @Published open var noun: Noun
    @Published open var translation: String?

    open var displayName: String {
        return declension.rawValue.uppercased() + " " + gender.rawValue.uppercased()
    }

    public static func inflector(for noun: Noun) -> NounInflector? {
        switch (noun.declension, noun.gender) {
        case (1, "m"):
            return FirstDeclensionMasculineNounInflector(noun: noun)
        case (2, "f"):
            return SecondDeclensionFeminineNounInflector(noun: noun)
        default:
            return nil
        }
    }

    fileprivate init(noun: Noun,
                     gender: Gender,
                     declension: Declension,
                     translation: String? = nil) {
        self.noun = noun
        self.gender = gender
        self.declension = declension
        self.translation = translation
        super.init()
    }

    open func inflect(grammaticalCase: Case, number: Verb.Number) -> String? {
        return nil
    }

}

public class FirstDeclensionMasculineNounInflector: NounInflector {

    public init(noun: Noun) {
        super.init(noun: noun, gender: .masculine, declension: .first, translation: noun.englishTranslation)
    }

    open override func inflect(grammaticalCase: Case, number: Verb.Number) -> String? {
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
            if noun.strongPlural {
                return noun.plural
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
    }

}

public class SecondDeclensionFeminineNounInflector: NounInflector {

    public init(noun: Noun) {
        super.init(noun: noun, gender: .feminine, declension: .second, translation: noun.englishTranslation)
    }

    open override func inflect(grammaticalCase: Case, number: Verb.Number) -> String? {
        if number == .singular {
            switch grammaticalCase {
            case .nominative, .dative:
                return noun.root
            case .vocative:
                return noun.root?.lenited
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
                return noun.plural?.lenited
            }
        }
    }

}
