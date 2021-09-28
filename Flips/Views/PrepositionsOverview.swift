//  Created by Jason R Tibbetts on 2/13/21.

import SwiftUI

struct PrepositionsOverview: View {

    var prepositions: [InflectedPreposition] = [Ag(), Ar(), As(), Chuig(), De(), Do(), Faoi(), I(), Le(), Ó(), Trí()]

    var body: some View {
        VStack {
            List {
                ForEach(prepositions, id: \.string) { (preposition) in
                    NavigationLink(destination: InflectedPrepositionDetailView(preposition: preposition)) {
                        HStack(spacing: 8.0) {
                            Text(preposition.string)
                            Spacer()
                            Text(preposition.englishTranslation)
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)

            Spacer()
        }
    }

}

struct InflectedPrepositionDetailView: View {

    var preposition: InflectedPreposition
    @State var displayEmphatic: Bool = false

    var body: some View {
        VStack {
            Text(preposition.string)
                .font(.headline)
            Text(preposition.englishTranslation)
                .font(.subheadline)
                .italic()

            Picker("List or Grid?", selection: $displayEmphatic) {
                Text("Normal").tag(false)
                Text("Emphatic").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())

            GroupBox {
                VStack(spacing: 8.0) {
                    HStack(spacing: 8.0) {
                        Text("Singular")
                        Spacer()
                        Text("Plural")
                    }

                    HStack(alignment: .top, spacing: 8.0) {
                        if displayEmphatic {
                            Text(preposition.inflectEmphatic(number: .singular, person: .first, gender: .none)!)
                            Spacer()
                            Text(preposition.inflectEmphatic(number: .plural, person: .first, gender: .none)!)
                        } else {
                            Text(preposition.inflect(number: .singular, person: .first, gender: .none)!)
                            Spacer()
                            Text(preposition.inflect(number: .plural, person: .first, gender: .none)!)
                        }
                    }

                    HStack(alignment: .top, spacing: 8.0) {
                        if displayEmphatic {
                            Text(preposition.inflectEmphatic(number: .singular, person: .second, gender: .none)!)
                            Spacer()
                            Text(preposition.inflectEmphatic(number: .plural, person: .second, gender: .none)!)
                        } else {
                            Text(preposition.inflect(number: .singular, person: .second, gender: .none)!)
                            Spacer()
                            Text(preposition.inflect(number: .plural, person: .second, gender: .none)!)

                        }
                    }

                    HStack(alignment: .top, spacing: 8.0) {
                        if displayEmphatic {
                            VStack(alignment: .leading) {
                                Text(preposition.inflectEmphatic(number: .singular, person: .third, gender: .masculine)!)
                                Text(preposition.inflectEmphatic(number: .singular, person: .third, gender: .feminine)!)
                            }
                            Spacer()
                            Text(preposition.inflectEmphatic(number: .plural, person: .third, gender: .none)!)
                        } else {
                            VStack(alignment: .leading) {
                                Text(preposition.inflect(number: .singular, person: .third, gender: .masculine)!)
                                Text(preposition.inflect(number: .singular, person: .third, gender: .feminine)!)
                            }
                            Spacer()
                            Text(preposition.inflect(number: .plural, person: .third, gender: .none)!)
                        }
                    }
                }
            }

            if let contractingPreposition = preposition as? ContractingPreposition {
                ContractingPrepositionDetailView(preposition: contractingPreposition)
            }

            Spacer()
        }
    }

}

private struct DefiniteArticleContractionView: View {

    @State var definiteArticle: DefiniteArticle

    @State var preposition: ContractingPreposition

    var body: some View {
        ContractingPrepositionEntryView(contractingElement: definiteArticle.rawValue,
                                        contraction: preposition.contractedWith(definiteArticle))
    }

}

private struct PossessiveContractionView: View {

    @State var possessivePronoun: PossessivePronoun

    @State var preposition: ContractingPreposition

    var body: some View {
        ContractingPrepositionEntryView(contractingElement: possessivePronoun.string,
                                        contraction: preposition.contractedWith(possessivePronoun))
    }

}

private struct ContractingPrepositionEntryView: View {

    @State var contractingElement: String

    @State var contraction: String

    var body: some View {
        HStack {
            Text(contractingElement)
                .bold()
            Spacer()
            Text(contraction)
                .italic()
        }
    }

}

struct ContractingPrepositionDetailView: View {

    @State var preposition: ContractingPreposition

    var body: some View {
        VStack {
            GroupBox {
                Text("With a definite article")
                DefiniteArticleContractionView(definiteArticle: .singular, preposition: preposition)
                DefiniteArticleContractionView(definiteArticle: .plural, preposition: preposition)
           }

            GroupBox {
                Text("With possessives")
                PossessiveContractionView(possessivePronoun: .firstSingular,
                                          preposition: preposition)
                PossessiveContractionView(possessivePronoun: .secondSingular,
                                          preposition: preposition)
                PossessiveContractionView(possessivePronoun: .thirdSingularMasculine,
                                          preposition: preposition)
                PossessiveContractionView(possessivePronoun: .thirdSingularFeminine,
                                          preposition: preposition)
                PossessiveContractionView(possessivePronoun: .firstPlural,
                                          preposition: preposition)
                PossessiveContractionView(possessivePronoun: .thirdPlural,
                                          preposition: preposition)
            }
        }
    }

}
struct PrepositionsOverviewPreviews: PreviewProvider {

    static var previews: some View {
        PrepositionsOverview()
    }

}
