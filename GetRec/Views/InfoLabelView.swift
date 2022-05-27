//
//  InfoLabelView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/2/22.
//

import SwiftUI

struct InfoLabelView: View {
    // MARK: - PROPERTIES
    
    var labelText: String
    var labelImage: String
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        } //: HSTACK
    }
}

struct InfoLabelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoLabelView(labelText: "Deneme", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
