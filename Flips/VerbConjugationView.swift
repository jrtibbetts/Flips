//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct InflectionCell: View {

    var ending: String? = ""

    var pronoun: String? = ""

    var verb: Verb?

    var body: some View {
        GeometryReader { (proxy) in
            HStack {
                HStack {
                    Text(verb?.root ?? "")
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 0)

                    if let ending = ending {
                        Text(ending)
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -6)
                    }
                }

                if let pronoun = pronoun {
                    Text(pronoun)
                }
            }
        }
    }

}

struct InflectionTableRow: View {

    var verb: Verb

    var person: Verb.Person

    var tense: Verb.Tense

    var mood: Verb.Mood

    var voice: Verb.Voice

    var conjugation: Verb.Conjugation

    var syllables: Verb.Syllables {
        return verb.polysyllabic ? .doubleOrMore : .single
    }

    var rootVowel: Verb.RootVowel {
        return Verb.RootVowel.value(for: verb.rootVowel)
    }

    var singularPronoun: String

    var pluralPronoun: String

    var body: some View {
        HStack {
            if let singularInflections = Verb.endings[.init(person: person,
                                                            number: Verb.Number.singular,
                                                            tense: tense,
                                                            mood: mood,
                                                            voice: voice,
                                                            conjugation: conjugation,
                                                            syllables: syllables,
                                                            rootVowel: rootVowel)] {
                InflectionCell(ending: singularInflections.ending,
                               pronoun: singularInflections.usePronoun ? singularPronoun : nil,
                               verb: verb)
            }

            if let pluralInflections = Verb.endings[.init(person: person,
                                                          number: Verb.Number.plural,
                                                          tense: tense,
                                                          mood: mood,
                                                          voice: voice,
                                                          conjugation: conjugation,
                                                          syllables: syllables,
                                                          rootVowel: rootVowel)] {
                InflectionCell(ending: pluralInflections.ending,
                               pronoun: pluralInflections.usePronoun ? pluralPronoun : nil,
                               verb: verb)
            }
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
                InflectionGroup(verb: verb, tense: .present, mood: .indicative, voice: .active, conjugation: .first)
                InflectionGroup(verb: verb, tense: .past, mood: .indicative, voice: .active, conjugation: .first)
                InflectionGroup(verb: verb, tense: .pastHabitual, mood: .indicative, voice: .active, conjugation: .first)
                InflectionGroup(verb: verb, tense: .future, mood: .indicative, voice: .active, conjugation: .first)
           }

            Spacer()
        }
    }
}

struct InflectionGroup: View {

    var verb: Verb
    var tense: Verb.Tense
    var mood: Verb.Mood
    var voice: Verb.Voice
    var conjugation: Verb.Conjugation

    var body: some View {
        VStack {
            HStack {
                Text(tense.rawValue.capitalized)
                    .font(.title2)
                Spacer()
            }

            ScrollView {
                InflectionTableRow(verb: verb,
                                   person: .first,
                                   tense: tense,
                                   mood: mood,
                                   voice: voice,
                                   conjugation: conjugation,
                                   singularPronoun: "mé",
                                   pluralPronoun: "muid")
                InflectionTableRow(verb: verb,
                                   person: .second,
                                   tense: tense,
                                   mood: mood,
                                   voice: voice,
                                   conjugation: conjugation,
                                   singularPronoun: "tú",
                                   pluralPronoun: "sibh")
                InflectionTableRow(verb: verb,
                                   person: .third,
                                   tense: tense,
                                   mood: mood,
                                   voice: voice,
                                   conjugation: conjugation,
                                   singularPronoun: "sé/sí",
                                   pluralPronoun: "siad")
            }
        }
        .padding(10.0)
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
