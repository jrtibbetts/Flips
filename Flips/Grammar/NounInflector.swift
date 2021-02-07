//  Created by Jason R Tibbetts on 1/31/21.

import Foundation

public class NounInflector: NSObject, ObservableObject {

    public struct Inflection {
        public var preposition: String?
        public var prefix: String?
        public var root: String
        public var ending: String
    }

    @Published open var declension: Declension
    @Published open var gender: Gender
    @Published open var noun: Noun
    @Published open var translation: String?

    open var displayName: String {
        return declension.rawValue.uppercased() + " " + gender.rawValue.uppercased()
    }

    public static func inflector(for noun: Noun) -> NounInflector? {
        switch noun.declension {
        case 1:
            return FirstDeclensionNounInflector(noun: noun)
        case 2:
            return SecondDeclensionNounInflector(noun: noun)
        case 3:
            return ThirdDeclensionNounInflector(noun: noun)
        case 4:
            return FourthDeclensionNounInflector(noun: noun)
        case 5:
            return FifthDeclensionNounInflector(noun: noun)
        default:
            return nil
        }
    }

    fileprivate init(noun: Noun,
                     declension: Declension) {
        self.noun = noun
        self.gender = Gender(abbreviation: noun.gender ?? "m")
        self.declension = declension
        self.translation = noun.englishTranslation
        super.init()
    }

    open func inflect(grammaticalCase: Case, number: Verb.Number) -> String? {
        return nil
    }

}

public class FirstDeclensionNounInflector: NounInflector {

    public init(noun: Noun) {
        super.init(noun: noun, declension: .first)
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

public class SecondDeclensionNounInflector: NounInflector {

    public init(noun: Noun) {
        super.init(noun: noun, declension: .second)
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
            if noun.strongPlural {
                return noun.plural
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

}

public class ThirdDeclensionNounInflector: NounInflector {

    public init(noun: Noun) {
        super.init(noun: noun, declension: .third)
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
            if noun.strongPlural {
                return noun.plural
            } else {
                switch grammaticalCase {
                case .nominative, .genitive, .dative:
                    return noun.plural
                case .vocative:
                    return noun.plural?.lenited
                }
            }
        }
    }

}

public class FourthDeclensionNounInflector: NounInflector {

    public init(noun: Noun) {
        super.init(noun: noun, declension: .fourth)
    }

    open override func inflect(grammaticalCase: Case, number: Verb.Number) -> String? {
        if number == .singular {
            switch grammaticalCase {
            case .nominative, .genitive, .dative:
                return noun.root
            case .vocative:
                return noun.root?.lenited
            }
        } else {
            if noun.strongPlural {
                return noun.plural
            } else {
                switch grammaticalCase {
                case .nominative, .genitive, .dative:
                    return noun.plural
                case .vocative:
                    return noun.plural?.lenited
                }
            }
        }
    }

}

public class FifthDeclensionNounInflector: NounInflector {

    public init(noun: Noun) {
        super.init(noun: noun, declension: .fifth)
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
            if noun.strongPlural {
                return noun.plural
            } else {
                switch grammaticalCase {
                case .nominative, .genitive, .dative:
                    return noun.plural
                case .vocative:
                    return noun.plural?.lenited
                }
            }
        }
    }

}
