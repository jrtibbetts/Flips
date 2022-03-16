//  Created by Jason R Tibbetts on 1/29/21.

import SwiftUI

extension Noun: DetailDisplayable {

    func detailView() -> AnyView {
        if let inflector = NounInflector.inflector(for: self) {
            return AnyView(NounDetailView(inflector: inflector, noun: self))
        } else {
            return AnyView(Text("No inflector found for \(self.root ?? "(no root)")"))
        }
    }

}

struct NounDetailView: View {

    @StateObject var inflector: NounInflector

    @StateObject var noun: Noun

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            if noun.englishTranslation != nil {
                HStack(spacing: 8.0) {
                    Text(noun.englishTranslation!)
                        .italic()
                    Text(noun.gender ?? "m") + Text(".")
                }
                .font(.subheadline)
            }

            ScrollView {
                GeometryReader { (proxy) in
                    HStack {
                        NumberInflectionView(inflector: inflector, number: .singular)
                            .frame(width: proxy.size.width / 2)
                        NumberInflectionView(inflector: inflector, number: .plural)
                            .frame(width: proxy.size.width / 2)
                    }
                }
            }
        }
        .navigationTitle(noun.dictionaryForm ?? "")
    }

}

struct NumberInflectionView: View {

    @StateObject var inflector: NounInflector

    @State var number: Grammar.Number

    var body: some View {
        VStack(alignment: .leading) {
            Text(number.rawValue.uppercased())
                .font(.subheadline)

            CaseNumberInflectionView(inflector: inflector, grammaticalCase: .nominative, number: number)
            CaseNumberInflectionView(inflector: inflector, grammaticalCase: .vocative, number: number)
            CaseNumberInflectionView(inflector: inflector, grammaticalCase: .genitive, number: number)
            CaseNumberInflectionView(inflector: inflector, grammaticalCase: .dative, number: number)
        }
    }

}

struct CaseNumberInflectionView: View {

    @StateObject var inflector: NounInflector

    @State var grammaticalCase: Case
    @State var number: Grammar.Number

    var body: some View {
        HStack {
            Text(grammaticalCase.rawValue.capitalized)
            Text(inflector.inflect(grammaticalCase: grammaticalCase, number: number) ?? "-")
                .bold()

        }
    }

}

struct NounDetailView_Previews: PreviewProvider {
    static var moon: Noun = {
        var noun = Noun(context: PersistenceController.preview.container.viewContext)
        noun.declension = 2
        noun.gender = "f"
        noun.root = "gealach"
        noun.genitive = "gealaí"
        noun.plural = "gealacha"
        noun.englishTranslation = "moon"

        return noun
    }()

    static var previews: some View {
        NounDetailView(inflector: SecondDeclensionNounInflector(noun: moon), noun: moon)
    }

}
