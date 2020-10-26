//  Created by Jason R Tibbetts on 10/22/20.

import AQUI
import SwiftUI

struct VerbEditor: View {

    struct TextFieldGroup: View {

        @State var value: String

        @State var name: String

        var body: some View {
            HStack {
                Text(name)

                TextField(name, text: Binding($value, ""))
                    .disableAutocorrection(true)
            }
        }

    }

    @ObservedObject var verb: Verb

    var body: some View {
        VStack(alignment: .center) {
            TextField("Dictionary Form",
                      text: Binding($verb.dictionaryForm, "no dictionary form"))
                .disableAutocorrection(true)
            TextField("Root",
                      text: Binding($verb.root, "no root"))
                .disableAutocorrection(true)

            Text("English Translations")
            VStack {
                TextField("English Present Tense",
                          text: Binding($verb.englishPresent, "no present tense"))
                    .disableAutocorrection(true)
                TextField("English Past Tense",
                          text: Binding($verb.englishPast, "no past tense"))
                    .disableAutocorrection(true)
                TextField("English Past Participle",
                          text: Binding($verb.englishPastParticiple, "no past participle"))
                    .disableAutocorrection(true)
           }
            .padding(5.0)

            Button("Save Changes") {
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
            VerbEditor(verb: verb)
            Spacer()
        }
    }

}
