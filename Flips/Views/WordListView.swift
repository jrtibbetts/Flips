//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

struct WordListView<T: Word>: View {

    @Environment(\.managedObjectContext) private var viewContext

    @AppStorage("displayAsGrid") private var displayAsGrid = true

    @State private var showingVerbEditor = false

    @State private var sortAscending = true

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "dictionaryForm",
                                           ascending: true,
                                           selector: #selector(NSString.localizedStandardCompare(_:)))],
        animation: .default)

    private var words: FetchedResults<T>

    var body: some View {
        ScrollView {
            if displayAsGrid {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],
                          alignment: .center, spacing: 20) {
                    ForEach(words) { (word) in
                        if let detailDisplayableWord = word as? DetailDisplayable,
                           let dictionaryForm = word.dictionaryForm ?? word.root {
                            NavigationLink(destination: detailDisplayableWord.detailView()) {
                                VStack {
                                    Text(dictionaryForm)
                                        .font(.title)

                                    if let translation = word.englishTranslation {
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
                        ForEach(words) { (word) in
                            if let detailDisplayableWord = word as? DetailDisplayable,
                               let dictionaryForm = word.dictionaryForm ?? word.root {
                                NavigationLink(destination: detailDisplayableWord.detailView()) {
                                    HStack(alignment: .firstTextBaseline) {
                                        Text(dictionaryForm)
                                            .font(.title)
                                        if let translation = word.englishTranslation {
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
//            leading:
//                Button(showingVerbEditor ? "Cancel" : "Add Verb") {
//                    showingVerbEditor.toggle()
//                },
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
        WordListView().environment(\.managedObjectContext,
                                PersistenceController.preview.container.viewContext)
    }
}
