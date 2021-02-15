//  Created by Jason R Tibbetts on 2/13/21.

import SwiftUI

struct PrepositionsOverview: View {

    var prepositions: [InflectedPreposition] = [Ag(), Ar(), As()]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(prepositions) { (preposition) in
                    Text(preposition.inflect(number: .singular, person: .first, gender: .masculine))
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
