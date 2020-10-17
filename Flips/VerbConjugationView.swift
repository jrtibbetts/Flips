//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct InflectionCell: View {

    var inflections: VerbInflection

    var body: some View {
        GeometryReader { (proxy) in
            HStack {
                HStack {
                    if let particle = inflections.particle {
                        Text(particle)
                            .font(.body)
                            .fontWeight(.bold)
                    }

                    if let prefix = inflections.prefix {
                        Text(prefix)
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(.trailing, -8)
                    }

                    Text(inflections.root)
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 0)

                    if let ending = inflections.ending {
                        Text(ending)
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -8)
                    }
                }

                if let pronoun = inflections.pronoun {
                    Text(pronoun)
                }
            }
        }
    }

}

struct InflectionTableRow: View {

    var inflector: VerbInflector

    var person: Verb.Person

    var body: some View {
        HStack {
            if let singularInflections = inflector.inflect(person: person, number: .singular) {
                InflectionCell(inflections: singularInflections)
            }

            if let pluralInflections = inflector.inflect(person: person, number: .plural) {
                InflectionCell(inflections: pluralInflections)
            }
       }
    }

}

struct MoodView<Content>: View where Content: View {

    let content: Content

    var mood: Verb.Mood

    init(_ mood: Verb.Mood,
         @ViewBuilder content: () -> Content) {
        self.mood = mood
        self.content = content()
    }

    var body: some View {
        VStack {
            Text(mood.rawValue)
                .font(.headline)
            content
        }
        .scaledToFill()
    }

}

struct VerbConjugationView: View {

    @State private var showTranslation: Bool = false

    var verb: Verb

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    MoodView(.indicative) {
                        InflectionGroup(inflector: FirstConjugationPresentIndicative(verb: verb))
                        InflectionGroup(inflector: FirstConjugationPastIndicative(verb: verb))
                        InflectionGroup(inflector: FirstConjugationPastHabitualIndicative(verb: verb))
                        InflectionGroup(inflector: FirstConjugationFutureIndicative(verb: verb))
                    }

                    MoodView(.conditional) {
                        InflectionGroup(inflector: FirstConjugationConditional(verb: verb))
                    }

                    MoodView(.subjunctive) {
                        InflectionGroup(inflector: FirstConjugationPresentSubjunctive(verb: verb))
                        InflectionGroup(inflector: FirstConjugationPastSubjunctive(verb: verb))
                    }
                }
            }
        }
        .padding([.leading, .trailing], 5)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(verb.root ?? "(no root)")
                        .font(.headline)

                    if let translation = verb.englishPresent {
                        Text(translation)
                            .font(.subheadline)
                    }
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Button("Show Translations") {
                    showTranslation.toggle()
                }
            }
        }
    }
}

struct InflectionGroup: View {

    var inflector: VerbInflector

    var body: some View {
        VStack {
            HStack {
                if let tense = inflector.tense?.rawValue {
                    Text(tense)
                        .font(.title2)

                    Spacer()
                }

                if let translation = inflector.translation {
                    Text(translation)
                        .font(.body)
                }
            }

            InflectionTableRow(inflector: inflector, person: .first)
            InflectionTableRow(inflector: inflector, person: .second)
            InflectionTableRow(inflector: inflector, person: .third)
        }
        .padding(10.0)
    }

}
struct VerbConjugationView_Previews: PreviewProvider {

    static var verb: Verb = {
        var verb = Verb(context: PersistenceController.preview.container.viewContext)
//        verb.root = "rith"
//        verb.rootVowel = "i"
//        verb.pastParticiple = "rite"
//        verb.verbalNoun = "rith"
//        verb.polysyllabic = false
        verb.root = "ól"
        verb.rootVowel = "ó"
        verb.pastParticiple = "ólta"
        verb.verbalNoun = "ól"
        verb.polysyllabic = false
        verb.englishPresent = "drink"
        verb.englishPast = "drank"
        verb.englishPastParticiple = "drunk"

        return verb
    }()

    static var previews: some View {
        NavigationView {
            VerbConjugationView(verb: verb)
        }
    }

}
