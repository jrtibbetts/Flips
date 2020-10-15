//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

struct CardsView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Verb.root, ascending: true)],
        animation: .default)

    private var verbs: FetchedResults<Verb>

    var body: some View {
        NavigationView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],
                      alignment: .center, spacing: 20) {
                ForEach(verbs) { verb in
                    NavigationLink(verb.root ?? "(no root)",
                                   destination: VerbConjugationView(verb: verb))
                }
            }
        }
    }

}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
