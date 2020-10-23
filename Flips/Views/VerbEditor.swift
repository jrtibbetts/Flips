//  Created by Jason R Tibbetts on 10/22/20.

import SwiftUI

struct VerbEditor: View {

    @Binding var verb: Verb

    @State var dictionaryForm: String = "Dictionary Form"
    @State var root: String = "Root"
    @State var simplePast: String = "Simple Past Tense"
    @State var pastParticiple: String = "Past Participle"
    @State var verbalNoun: String = "Verbal Noun"
    @State var englishPresent: String = "Present Tense"
    @State var englishPast: String = "Past Tense"
    @State var englishPastParticiple: String = "Past Participle"
    @State var polysyllabic: Bool = false
    @State var conjugation: Verb.Conjugation = .first

    var body: some View {
        VStack(alignment: .center) {
            TextField(verb.dictionaryForm ?? dictionaryForm,
                      text: $dictionaryForm)
            TextField(verb.root ?? root,
                      text: $root)

            Text("English Translations")
            VStack {
                TextField(verb.englishPresent ?? englishPresent,
                          text: $englishPresent)
                TextField(verb.englishPast ?? englishPast,
                          text: $englishPast)
                TextField(verb.englishPastParticiple ?? englishPastParticiple,
                          text: $englishPastParticiple)
            }
            .padding(5.0)

            Button("Save Changes") {
                verb.dictionaryForm = dictionaryForm
            }
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
