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

    var body: some View {
        GroupBox {
            if let inflectedForm = preposition.inflect(number: .singular, person: .first, gender: .masculine) {
                Text(inflectedForm)
            }
        }
    }

}

struct PrepositionsOverview_Previews: PreviewProvider {

    static var previews: some View {
        PrepositionsOverview()
    }

}
