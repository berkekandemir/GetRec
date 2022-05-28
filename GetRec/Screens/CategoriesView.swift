//
//  CategoriesView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/1/22.
//

import SwiftUI

struct CategoriesView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var network: Network
    @AppStorage("info") private var isShowingInfo: Bool = false
    @AppStorage("screen") var screen: Int = 4
    @AppStorage("return") var isReturn: Bool = false
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { metrics in
            NavigationView {
                if (network.apps.count != 0) {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(network.apps) { app in
                            NavigationLink(destination: GetRecommendationsView(title: app.name, color: app.color.components(separatedBy: "#")[1])) {
                                AppsListView(name: app.name, chevron: true, hex: app.color.components(separatedBy: "#")[1], image: true, info1Name: "", info1Detail: "", info2Name: "", info2Detail: "", height: 100)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            hapticImpact.impactOccurred()
                        })
                    } //: SCROLL VIEW
                    .navigationBarTitle("Categories", displayMode: .automatic)
                    .navigationBarItems(
                        leading:
                            Button(action: {
                                withAnimation {
                                    hapticImpact.impactOccurred()
                                    isReturn = true
                                    screen = 3
                                }
                                network.logout()
                            }) {
                                Text("Log out")
                            }, //: BUTTON
                        trailing:
                            HStack(spacing: 10) {
                                Button(action: {
                                    hapticImpact.impactOccurred()
                                    isShowingInfo = true
                            }) {
                                Image(systemName: "info.circle.fill")
                                } //: BUTTON
                                .foregroundColor(.accentColor)
                                .font(.system(size: 18))
                                .sheet(isPresented: $isShowingInfo) {
                                    InfoView()
                                }
                            } //: HSTACK
                    )
                } else {
                    VStack {
                        LoaderView(tintColor: .accentColor, scaleSize: 2.0).padding(.bottom,100)
                    }
                }
            } //: NAVIGATION VIEW
        } //: GEOMETRY READER
        .onAppear {
            network.getApps()
        }
    }
}

// MARK: - PREVIEW
struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(Network())
    }
}
