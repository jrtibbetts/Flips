//  Created by Jason R Tibbetts on 10/22/20.

import AQUI
import SwiftUI

struct VerbEditor: View {

    struct EditPreferenceData: Equatable {
        let frame: CGRect
        let valueChanged: Bool
    }

    struct EditPreferenceKey: PreferenceKey {

        static var defaultValue: [EditPreferenceData] = []

        static func reduce(value: inout [EditPreferenceData],
                           nextValue: () -> [EditPreferenceData]) {
            value.append(contentsOf: nextValue())
        }

    }

    struct TextFieldGroup: View {

        @State var name: String

        @State var geometryProxy: GeometryProxy

        @Binding var value: String

        var body: some View {
            HStack(spacing: 10.0) {
                Text(name)
                    .frame(width: geometryProxy.size.width * 0.4, alignment: .leading)

                TextField(name, text: $value)
                    .disableAutocorrection(true)
                    .padding(2.0)
                    .border(Color.secondary, width: 1.0)
            }
            .padding([.top, .bottom], 5.0)
        }

    }

    @ObservedObject var verb: Verb

    @Binding var showingVerbEditor: Bool

    var body: some View {
        GeometryReader { (proxy) in
            VStack(alignment: .center) {
                VStack {
                    TextFieldGroup(name: "Dictionary Form",
                                   geometryProxy: proxy,
                                   value: Binding($verb.dictionaryForm, ""))
                    TextFieldGroup(name: "Root",
                                   geometryProxy: proxy,
                                   value: Binding($verb.root, ""))
                    TextFieldGroup(name: "Root Vowel",
                                   geometryProxy: proxy,
                                   value: Binding($verb.rootVowel, ""))
                    TextFieldGroup(name: "Simple Past Root",
                                   geometryProxy: proxy,
                                   value: Binding($verb.simplePastRoot, ""))
                    TextFieldGroup(name: "Past Participle",
                                   geometryProxy: proxy,
                                   value: Binding($verb.pastParticiple, ""))
                    TextFieldGroup(name: "Verbal Noun",
                                   geometryProxy: proxy,
                                   value: Binding($verb.verbalNoun, ""))

                    VStack {
                        HStack {
                            Text("Conjugation")
                                .frame(width: proxy.size.width * 0.4,
                                       alignment: .leading)
                            Picker("", selection: $verb.conjugation) {
                                Text("First").tag(Verb.Conjugation.first.rawValue)
                                Text("Second").tag(Verb.Conjugation.second.rawValue)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        //                        .frame(height: 40.0)

                        HStack {
                            Text("Polysyllabic")
                                .frame(width: proxy.size.width * 0.4, alignment: .leading)
                            Picker("Polysyllabic", selection: $verb.polysyllabic) {
                                Text("True").tag(true)
                                Text("False").tag(false)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        //                        .frame(height: 40.0)
                    }
                }

                VStack {
                    TextFieldGroup(name: "English Present Tense",
                                   geometryProxy: proxy,
                                   value: Binding($verb.englishPresent, ""))
                    TextFieldGroup(name: "English Past Tense",
                                   geometryProxy: proxy,
                                   value: Binding($verb.englishPast, ""))
                    TextFieldGroup(name: "English Past Participle",
                                   geometryProxy: proxy,
                                   value: Binding($verb.englishPastParticiple, ""))
                }

                Button("Save Changes") {
                    try! PersistenceController.preview.container.viewContext.save()
                    showingVerbEditor = false
                }

                Spacer()
            }
        }
    }

}

struct VerbEditor_Previews: PreviewProvider {

    @State static var verb = Verb(context: PersistenceController.preview.container.viewContext)
    @State static var showingVerbEditor: Bool = true

    static var previews: some View {
        ScrollView {
            VStack {
                VerbEditor(verb: verb, showingVerbEditor: $showingVerbEditor)
                    .padding([.leading, .trailing], 10.0)
            }
        }
    }

}
