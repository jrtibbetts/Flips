//  Created by Jason R Tibbetts on 2/13/21.

import SwiftUI

struct PrepositionsOverview: View {

    var prepositions: [InflectedPreposition] = [Ag(), Ar(), As(), Chuig(), De(), Do(), Faoi(), I(), Le(), Ó(), Trí()]

    var body: some View {
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
    }

}

struct InflectedPrepositionDetailView: View {

    var preposition: InflectedPreposition
    @State var displayEmphatic: Bool = false

    var body: some View {
        VStack {
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
                            Text(preposition.inflect(number: .plural, person: .first, gender: .none)!)                        }
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
        }
    }

}

struct ContractingPrepositionDetailView: View {

    @State var preposition: ContractingPreposition

    var body: some View {
        VStack {
            GroupBox {
                Text("With a definite article")
                HStack {
                    Text(DefiniteArticle.singular.rawValue)
                    Spacer()
                    Text(preposition.contractedWith(.singular))
                }
                HStack {
                    Text(DefiniteArticle.plural.rawValue)
                    Spacer()
                    Text(preposition.contractedWith(.plural))
                }
            }
        }
    }

}
struct PrepositionsOverviewPreviews: PreviewProvider {

    static var previews: some View {
        PrepositionsOverview()
    }

}
