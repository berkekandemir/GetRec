//
//  HomeView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/1/22.
//

import SwiftUI

struct AppsView: View {
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
                            NavigationLink(destination: GetRecommendationsView(title: "\(app.name)")) {
                                AppsListView(name: "\(app.name)", chevron: true, fontHeavy: true, hex: "\(app.color.components(separatedBy: "#")[1])")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            hapticImpact.impactOccurred()
                        })
                    } //: SCROLL VIEW
                    .navigationBarTitle("Apps", displayMode: .automatic)
                    .navigationBarItems(
                        leading:
                            Button(action: {
                                withAnimation {
                                    hapticImpact.impactOccurred()
                                    isReturn = true
                                    screen = 3
                                }
                                network.logOut()
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

struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

// MARK: - PREVIEW
struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .environmentObject(Network())
    }
}
