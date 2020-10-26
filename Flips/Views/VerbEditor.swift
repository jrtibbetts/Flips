//  Created by Jason R Tibbetts on 10/22/20.

import AQUI
import SwiftUI

struct VerbEditor: View {

    struct TextFieldGroup: View {

        @State var name: String

        @Binding var value: String

        var body: some View {
//            GeometryReader { (proxy) in
                HStack(spacing: 10.0) {
                    Text("\(name):")
//                        .frame(width: proxy.size.width * 0.4)

                    TextField(name, text: $value)
                        .disableAutocorrection(true)
                        .border(Color.secondary, width: 1.0)
                }
//                .frame(idealHeight: 20.0)
//            }
        }

    }

    @ObservedObject var verb: Verb

    var body: some View {
        VStack(alignment: .center) {
            TextFieldGroup(name: "Dictionary Form",
                           value: Binding($verb.dictionaryForm, ""))
            TextFieldGroup(name: "Root",
                           value: Binding($verb.root, ""))

            Text("English Translations")
            VStack {
                TextFieldGroup(name: "English Present Tense",
                               value: Binding($verb.englishPresent, ""))
                TextFieldGroup(name: "English Past Tense",
                               value: Binding($verb.englishPast, ""))
                TextFieldGroup(name: "English Past Participle",
                               value: Binding($verb.englishPastParticiple, ""))
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
