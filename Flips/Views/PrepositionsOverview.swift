//  Created by Jason R Tibbetts on 2/13/21.

import SwiftUI

struct PrepositionsOverview: View {

    var prepositions: [InflectedPreposition] = [Ag(), Ar(), As(), Chuig(), De(), Do(), Faoi(), Le(), Ó(), Trí()]

    var body: some View {
        List {
            ForEach(prepositions, id: \.id) { (preposition) in
                NavigationLink(destination: InflectedPrepositionDetailView(preposition: preposition)) {
                    HStack(spacing: 8.0) {
                        Text(preposition.id)
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
    var displayEmphatic: Bool

    var body: some View {
        VStack {
            Picker("List or Grid?", selection: $displayEmphatic) {
                Text("List").tag(false)
                Text("Grid").tag(true)
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
                    Text(preposition.inflect(number: .singular, person: .first, gender: .none)!)
                    Spacer()
                    Text(preposition.inflect(number: .plural, person: .first, gender: .none)!)
                }

                HStack(alignment: .top, spacing: 8.0) {
                    Text(preposition.inflect(number: .singular, person: .second, gender: .none)!)
                    Spacer()
                    Text(preposition.inflect(number: .plural, person: .second, gender: .none)!)
                }

                HStack(alignment: .top, spacing: 8.0) {
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
    }

}

struct PrepositionsOverview_Previews: PreviewProvider {

    static var previews: some View {
        PrepositionsOverview()
    }

}
