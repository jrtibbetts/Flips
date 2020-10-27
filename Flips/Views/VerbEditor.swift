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

    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var verb: Verb

    var body: some View {
        VStack(alignment: .center) {
            TextFieldGroup(name: "Dictionary Form",
                           value: Binding($verb.dictionaryForm, ""))
            TextFieldGroup(name: "Root",
                           value: Binding($verb.root, ""))
            TextFieldGroup(name: "Simple Past Root",
                           value: Binding($verb.simplePastRoot, ""))
            TextFieldGroup(name: "Past Participle",
                           value: Binding($verb.pastParticiple, ""))
            TextFieldGroup(name: "Verbal Noun",
                           value: Binding($verb.verbalNoun, ""))
            TextFieldGroup(name: "English Present Tense",
                           value: Binding($verb.englishPresent, ""))
            TextFieldGroup(name: "English Past Tense",
                           value: Binding($verb.englishPast, ""))
            TextFieldGroup(name: "English Past Participle",
                           value: Binding($verb.englishPastParticiple, ""))

            Button("Save Changes") {
                try! PersistenceController.preview.container.viewContext.save()
                presentationMode.wrappedValue.dismiss()
            }
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
