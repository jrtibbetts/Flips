//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

struct CardsView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @AppStorage("displayAsGrid") private var displayAsGrid = true

    @State private var showingVerbEditor = false

    @State private var sortAscending = true

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "dictionaryForm",
                                           ascending: true,
                                           selector: #selector(NSString.localizedStandardCompare(_:)))],
        animation: .default)

    private var verbs: FetchedResults<Verb>

    var body: some View {
        ScrollView {
            if displayAsGrid {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],
                          alignment: .center, spacing: 20) {
                    ForEach(verbs) { (verb) in
                        if let dictionaryForm = verb.dictionaryForm ?? verb.root {
                            NavigationLink(destination: VerbConjugationView(verb: verb)) {
                                VStack {
                                    Text(dictionaryForm)
                                        .font(.title)
                                    
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
            } else {
                HStack() {
                    Spacer()
                    VStack {
                        ForEach(verbs) { (verb) in
                            if let dictionaryForm = verb.dictionaryForm ?? verb.root {
                                NavigationLink(destination: VerbConjugationView(verb: verb)) {
                                    HStack(alignment: .firstTextBaseline) {
                                        Text(dictionaryForm)
                                            .font(.title)
                                        if let translation = verb.englishPresent {
                                            Spacer()
                                            Text(translation)
                                                .font(.headline)
                                                .italic()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Irish Verbs")
        .navigationBarItems(
            leading:
                Button(showingVerbEditor ? "Cancel" : "Add Verb") {
                    showingVerbEditor.toggle()
                },
            trailing:
                Picker("List or Grid?", selection: $displayAsGrid) {
                    Text("List").tag(false)
                    Text("Grid").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
        )
    }

}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView().environment(\.managedObjectContext,
                                PersistenceController.preview.container.viewContext)
    }
}
