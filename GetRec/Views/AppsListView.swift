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
    var recom: Bool? = nil
    let hex: String
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    let image: Bool
    let info1Name: String
    let info1Detail: String
    let info2Name: String
    let info2Detail: String
    let height: Int
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            HStack {
                if (image) {
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 10)
                }
                VStack {
                    Text(name)
                        .font(.body)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .padding(.horizontal, image ? 0 : 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if (recom != nil) {
                        HStack {
                            Text("\(info1Name):")
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                            Text(info1Detail)
                                .font(.body)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.horizontal, image ? 0 : 10)
                        if (recom != nil) {
                            HStack {
                                Text("\(info2Name):")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                Text(info2Detail)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.horizontal, image ? 0 : 10)
                        }
                    }
                }
                Spacer()
                if (chevron) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                }
            } //: HSTACK
            Spacer()
        } //: VSTACK
        .frame(height: CGFloat(height))
        .background(Color(hex: hex))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: Color(hex: hex), radius: 4, x: 0, y: 0)
        .padding(5)
        .padding(.horizontal, 15)
    }
}

// MARK: - PREVIEW
struct AppsListView_Previews: PreviewProvider {
    static var previews: some View {
        AppsListView(name: "Games", chevron: false, recom: true, hex: "ffffff", image: false, info1Name: "Author", info1Detail: "XXXXXX", info2Name: "Topic", info2Detail: "XXXXXX", height: 100)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
