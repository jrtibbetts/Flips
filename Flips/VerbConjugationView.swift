//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct VerbConjugationView: View {

    @State private var showTranslation: Bool = false
    @State private var mode = "positive"

    var verb: Verb

    var body: some View {
        VStack {
            Picker("", selection: $mode) {
                Text("Positive").tag("positive")
                Text("Ní").tag("negative")
                Text("An").tag("interrogative")
                Text("Nach").tag("negative interrogative")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            ScrollView {
                VStack {
                    MoodView(.indicative) {
                        InflectionGroup(inflector: FirstConjugationPresentIndicative(verb: verb),
                                        showTranslations: $showTranslation)
                        InflectionGroup(inflector: FirstConjugationPastIndicative(verb: verb),
                                        showTranslations: $showTranslation)
                        InflectionGroup(inflector: FirstConjugationPastHabitualIndicative(verb: verb),
                                        showTranslations: $showTranslation)
                        InflectionGroup(inflector: FirstConjugationFutureIndicative(verb: verb),
                                        showTranslations: $showTranslation)
                    }

                    MoodView(.conditional) {
                        InflectionGroup(inflector: FirstConjugationConditional(verb: verb),
                                        showTranslations: $showTranslation)
                    }

                    MoodView(.subjunctive) {
                        InflectionGroup(inflector: FirstConjugationPresentSubjunctive(verb: verb),
                                        showTranslations: $showTranslation)
                        InflectionGroup(inflector: FirstConjugationPastSubjunctive(verb: verb),
                                        showTranslations: $showTranslation)
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

struct InflectionGroup: View {

    var inflector: VerbInflector

    @Binding var showTranslations: Bool

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

            InflectionTableRow(inflector: inflector, person: .first,
                               showTranslations: $showTranslations)
            InflectionTableRow(inflector: inflector, person: .second,
                               showTranslations: $showTranslations)
            InflectionTableRow(inflector: inflector, person: .third,
                               showTranslations: $showTranslations)
        }
        .padding(10.0)
    }

}

struct InflectionTableRow: View {

    var inflector: VerbInflector

    var person: Verb.Person

    @Binding var showTranslations: Bool

    var body: some View {
        HStack {
            if let singularInflections = inflector.inflect(person: person, number: .singular) {
                InflectionCell(inflections: singularInflections,
                               showTranslations: $showTranslations)
            }

            if let pluralInflections = inflector.inflect(person: person, number: .plural) {
                InflectionCell(inflections: pluralInflections,
                               showTranslations: $showTranslations)
            }
       }
    }

}

struct InflectionCell: View {

    var inflections: VerbInflection

    @Binding var showTranslations: Bool

    var body: some View {
        GeometryReader { (proxy) in
            VStack{
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
                        .frame(alignment: .leading)
                        .padding(.trailing, 0)

                    if let ending = inflections.ending {
                        Text(ending)
                            .font(.body)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                            .padding(.leading, -8)
                    }

                    if let pronoun = inflections.pronoun {
                        Text(pronoun)
                    }
                }

                if showTranslations,
                   let translation = inflections.translation {
                    Text(translation)
                        .font(.footnote)
                        .frame(alignment: .leading)
                }
            }
            .frame(alignment: .leading)
        }
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
