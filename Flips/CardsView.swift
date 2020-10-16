//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

struct CardsView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @State private var sortAscending = true

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "root",
                                           ascending: true,
                                           selector: #selector(NSString.localizedStandardCompare(_:)))],
        animation: .default)

    private var verbs: FetchedResults<Verb>

    var body: some View {
        NavigationView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],
                      alignment: .center, spacing: 20) {
                ForEach(verbs) { verb in
                    if let root = verb.root {
                        NavigationLink(root,
                                       destination: VerbConjugationView(verb: verb))
                    }
                }
            }

            Spacer()
        }
    }

}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
