//
//  InfoView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/2/22.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    @AppStorage("screen") var screen: Int = 6
    @AppStorage("return") var isReturn: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    GroupBox(label: InfoLabelView(labelText: "Account", labelImage: "person.crop.circle")) {
                        InfoRowView(name: "E-mail", content: "berke@gmail.com")
                    } //: BOX
                    
                    GroupBox(label: InfoLabelView(labelText: "GetRec", labelImage: "info.circle")) {
                        
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 10) {
                            Image("GetRec-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)
                            
                            Text("You can use GetRec to find a suggestion for everything you can imagine. If you find a missing category, please reach us!")
                                .font(.footnote)
                            
                        } //: HSTACK
                    } //: BOX
                    
                    GroupBox (label: InfoLabelView(labelText: "About the App", labelImage: "apps.iphone")) {
                        InfoRowView(name: "Course Code", content: "CENG 318")
                        InfoRowView(name: "Developers", content: "Group 9")
                        InfoRowView(name: "Website", linkLabel: "Website", linkDestination: "www.berkecankandemir.com")
                        InfoRowView(name: "Version", content: "0.1.0")
                        
                    } //: BOX
                } //: VSTACK
            } //: SCROLL
            .padding()
            .navigationBarTitle(Text("Information"), displayMode: .large)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        hapticImpact.impactOccurred()
                    }) {
                    Image(systemName: "xmark")
                    } //: BUTTON
                    .foregroundColor(Color("ColorRed"))
                    .font(.system(size: 20))
            )
        } //: NAVIGATION
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
