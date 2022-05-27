//
//  AppsListView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/2/22.
//

import SwiftUI
import UIKit

struct AppsListView: View {
    // MARK: - PROPERTIES
    let name: String
    let chevron: Bool
    let fontHeavy: Bool
    var hex: String
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            HStack {
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 10)
                Text(name)
                    .font(fontHeavy ? .title2: .body)
                    .fontWeight(fontHeavy ? .heavy : .regular)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Spacer()
                if (chevron) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                }
            } //: HSTACK
            Spacer()
        } //: VSTACK
        .frame(width: 375, height: 100)
        .background(Color(hex: hex))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: colorScheme == .dark ? .white : .secondary, radius: 4, x: 0, y: 0)
        .padding(5)
    }
}

// MARK: - PREVIEW
struct AppsListView_Previews: PreviewProvider {
    static var previews: some View {
        AppsListView(name: "Games", chevron: true, fontHeavy: false, hex: "007AAF")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
