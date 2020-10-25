//  Created by Jason R Tibbetts on 10/22/20.

import SwiftUI

struct VerbEditor: View {

    @Binding var verb: Verb {
        didSet {
            dictionaryForm = verb.dictionaryForm ?? "Dictionary form"
            root = verb.root ?? "Root"
            simplePast = verb.simplePastRoot ?? "Simple Past Tense"
            pastParticiple = verb.pastParticiple ?? "Past Participle"
            verbalNoun = verb.verbalNoun ?? "Verbal Noun"
            englishPresent = verb.englishPresent ?? "Present Tense"
            englishPast = verb.englishPast ?? "Past Tense"
            pastParticiple = verb.pastParticiple ?? "Past Participle"
            polysyllabic = verb.polysyllabic
            conjugation = Verb.Conjugation(rawValue: verb.conjugation) ?? .first
        }
    }

    @State var dictionaryForm: String = "* Dictionary Form"
    @State var root: String = "* Root"
    @State var simplePast: String = "* Simple Past Tense"
    @State var pastParticiple: String = "* Past Participle"
    @State var verbalNoun: String = "* Verbal Noun"
    @State var englishPresent: String = "* Present Tense"
    @State var englishPast: String = "* Past Tense"
    @State var englishPastParticiple: String = "* Past Participle"
    @State var polysyllabic: Bool = false
    @State var conjugation: Verb.Conjugation = .first

    var body: some View {
        VStack(alignment: .center) {
            Text("Is verb nil? \(verb.dictionaryForm == nil ? "yes" : "no")")
            TextField(verb.dictionaryForm ?? "foo",
                      text: $dictionaryForm)
                .disableAutocorrection(true)
            TextField(verb.root ?? root,
                      text: $root)
                .disableAutocorrection(true)

            Text("English Translations")
            VStack {
                TextField(verb.englishPresent ?? englishPresent,
                          text: $englishPresent)
                    .disableAutocorrection(true)
                TextField(verb.englishPast ?? englishPast,
                          text: $englishPast)
                    .disableAutocorrection(true)
                TextField(verb.englishPastParticiple ?? englishPastParticiple,
                          text: $englishPastParticiple)
                    .disableAutocorrection(true)
           }
            .padding(5.0)

            Button("Save Changes") {
                verb.dictionaryForm = dictionaryForm
                verb.root = root
                verb.pastParticiple = pastParticiple
                verb.verbalNoun = verbalNoun
                verb.englishPresent = englishPresent
                verb.englishPast = englishPast
                verb.englishPastParticiple = englishPastParticiple
                try! PersistenceController.preview.container.viewContext.save()
            }

            Text("Dictionary form: \(verb.dictionaryForm ?? "(none)")")
            Text("Root: \(verb.root ?? "(none)")")
            Text("English Present: \(verb.englishPresent ?? "(none)")")
            Text("English Past: \(verb.englishPast ?? "(none)")")
//            Text(verb.englishPastParticiple ?? "(none)")
//            Text("English Past Participle: \(verb.englishPastParticiple ?? "(none)")")
        }
    }

}

struct VerbEditor_Previews: PreviewProvider {

    @State static var verb = Verb(context: PersistenceController.preview.container.viewContext)

    static var previews: some View {
        VStack {
            VerbEditor(verb: $verb)
            Spacer()
        }
    }

}
