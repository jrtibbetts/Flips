//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

struct CardsView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @State private var sortAscending = true

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "dictionaryForm",
                                           ascending: true,
                                           selector: #selector(NSString.localizedStandardCompare(_:)))],
        animation: .default)

    private var verbs: FetchedResults<Verb>

    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],
                          alignment: .center, spacing: 20) {
                    ForEach(verbs) { verb in
                        if let dictionaryForm = verb.dictionaryForm ?? verb.root {
                            NavigationLink(destination: VerbConjugationView(verb: verb)) {
                                VStack {
                                    Text(dictionaryForm)
                                        .font(.largeTitle)

                                    if let translation = verb.englishPresent {
                                        Text(translation)
                                            .font(.headline)
                                            .italic()
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(10.0)
                    .border(Color.blue, width: 2)
                }

                Spacer()
            }
            .navigationTitle("Irish Verbs")
        }
    }

}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView().environment(\.managedObjectContext,
                                PersistenceController.preview.container.viewContext)
    }
}
