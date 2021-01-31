//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

protocol WordDetailView: View {

    associatedtype W: Word

    var word: W { get }

}
