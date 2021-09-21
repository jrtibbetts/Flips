//  Created by Jason R Tibbetts on 2/13/21.

import SwiftUI

struct PrepositionsOverview: View {

    var prepositions: [InflectedPreposition] = [Ag(), Ar(), As()]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(prepositions, id: \.id) { (preposition) in
                    if let inflectedForm = preposition.inflect(number: .singular, person: .first, gender: .masculine) {
                        Text(inflectedForm)
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
