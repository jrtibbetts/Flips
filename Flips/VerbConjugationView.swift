//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct VerbConjugationView: View {

    var verb: Verb

    var body: some View {
        VStack {
            HStack {
                Text(verb.root ?? "(no root)")
                    .font(.title)
            }

            GeometryReader { (proxy) in
                let proxyWidth = proxy.size.width

                VStack {
                    Text("Present")
                        .font(.title2)

                    HStack {
                        Text(verb.root! + "im")
                            .frame(width: proxyWidth * 0.3)
                        Text("")
                            .frame(width: proxyWidth * 0.15)
                        Text(verb.root! + "imid")
                            .frame(width: proxyWidth * 0.3)
                        Text("")
                            .frame(width: proxyWidth * 0.15)
                    }
                    HStack {
                        Text(verb.root! + "eann")
                            .frame(width: proxyWidth * 0.3)
                        Text("tú")
                            .frame(width: proxyWidth * 0.15)
                        Text(verb.root! + "eann")
                            .frame(width: proxyWidth * 0.3)
                        Text("sibh")
                            .frame(width: proxyWidth * 0.15)
                    }
                    HStack {
                        Text(verb.root! + "eann")
                            .frame(width: proxyWidth * 0.3)
                        Text("sé/sí")
                            .frame(width: proxyWidth * 0.15)
                        Text(verb.root! + "eann")
                            .frame(width: proxyWidth * 0.3)
                        Text("siad")
                            .frame(width: proxyWidth * 0.15)
                    }
                }
            }
            Spacer()
        }
    }
}

struct VerbConjugationView_Previews: PreviewProvider {

    static var verb: Verb = {
        var verb = Verb(context: PersistenceController.preview.container.viewContext)
        verb.root = "siul"

        return verb
    }()

    static var previews: some View {
        VerbConjugationView(verb: verb)
    }

}
