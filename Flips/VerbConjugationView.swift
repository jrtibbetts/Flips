//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct InflectionCell: View {

    var ending: String? = ""

    var pronoun: String? = ""

    var root: String? = ""

    var body: some View {
        GeometryReader { (proxy) in
            HStack {
                HStack {
                    Text(root ?? "")
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                    Text(ending ?? "" )
                        .font(.body)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }

                Text(pronoun ?? "")
            }

        }
    }
}

struct InflectionTableRow: View {

    var root: String = ""

    var person: Verb.Person

    var tense: Verb.Tense

    var mood: Verb.Mood

    var voice: Verb.Voice

    var declension: Verb.Declension

    var syllables: Verb.Syllables

    var rootVowel: Verb.Vowel

    var singularPronoun: String

    var pluralPronoun: String

    var body: some View {
        HStack {
            let singularEnding = Verb.endings[.init(person: person,
                                                    number: Verb.Number.singular,
                                                    tense: tense,
                                                    mood: mood,
                                                    voice: voice,
                                                    declension: declension,
                                                    syllables: syllables,
                                                    vowel: rootVowel)]
            InflectionCell(ending: singularEnding, pronoun: singularPronoun, root: root)

            let pluralEnding   = Verb.endings[.init(person: person,
                                                    number: Verb.Number.plural,
                                                    tense: tense,
                                                    mood: mood,
                                                    voice: voice,
                                                    declension: declension,
                                                    syllables: syllables,
                                                    vowel: rootVowel)]
            InflectionCell(ending: pluralEnding, pronoun: singularPronoun, root: root)
       }
    }

}

struct VerbConjugationView: View {

    var verb: Verb

    var body: some View {
        VStack {
            HStack {
                Text(verb.root ?? "(no root)")
                    .font(.title)
            }

            VStack {
                Text("Present")
                    .font(.title2)

                InflectionTableRow(root: verb.root!,
                                   person: .first,
                                   tense: .present,
                                   mood: .indicative,
                                   voice: .active,
                                   declension: .first,
                                   syllables: .single,
                                   rootVowel: .slender,
                                   singularPronoun: "",
                                   pluralPronoun: "")
                InflectionTableRow(root: verb.root!,
                                   person: .second,
                                   tense: .present,
                                   mood: .indicative,
                                   voice: .active,
                                   declension: .first,
                                   syllables: .single,
                                   rootVowel: .slender,
                                   singularPronoun: "",
                                   pluralPronoun: "")
                InflectionTableRow(root: verb.root!,
                                   person: .third,
                                   tense: .present,
                                   mood: .indicative,
                                   voice: .active,
                                   declension: .first,
                                   syllables: .single,
                                   rootVowel: .slender,
                                   singularPronoun: "",
                                   pluralPronoun: "")
           }

            Spacer()
        }
    }
}

struct VerbConjugationView_Previews: PreviewProvider {

    static var verb: Verb = {
        var verb = Verb(context: PersistenceController.preview.container.viewContext)
        verb.root = "rith"
        verb.rootVowel = "i"
        verb.pastParticiple = "rite"
        verb.verbalNoun = "rith"

        return verb
    }()

    static var previews: some View {
        VerbConjugationView(verb: verb)
    }

}
