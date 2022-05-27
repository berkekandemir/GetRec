//
//  InfoRowView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/2/22.
//

import SwiftUI

struct InfoRowView: View {
    //    MARK: - PROPERTIES
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil
        
    //    MARK: - BODY
    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)
            
            HStack {
                Text(name).foregroundColor(Color.gray)
                Spacer()
                if (content != nil) {
                    Text(content!)
                } else if (linkLabel != nil && linkDestination != nil) {
                    Link(linkLabel!, destination: URL(string: "https://\(linkDestination!)")!)
                    Image(systemName: "arrow.up.right.square").foregroundColor(.accentColor)
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
            } //: HSTACK
        } //: VSTACK
    }
}

    // MARK: - REVIEW
struct InfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InfoRowView(name: "Developer", content: "Berke Can Kandemir")
                .previewLayout(.fixed(width: 375, height: 60))
                .padding()
            InfoRowView(name: "Website", linkLabel: "LinkedIn", linkDestination: "www.linkedin.com/in/berke-can-kandemir/")
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 375, height: 60))
                .padding()
        }
    }
}
