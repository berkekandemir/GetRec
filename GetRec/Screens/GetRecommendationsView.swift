//
//  GetRecommendationsView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/2/22.
//

import SwiftUI
import Combine

struct GetRecommendationsView: View {
    // MARK: - PROPERTIES
    let title: String
    @State private var listItems: Array<String>?
    @State private var searchParam: String = ""
    @State private var results: Bool = false
    private enum Field: Int, CaseIterable {
        case searchParam
    }
    @FocusState private var focusedField: Field?
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { metrics in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                        .padding(.top, 15)
                    GroupBox {
                        TextField(
                            "Search Query",
                            text: $searchParam
                        ) //: TEXTFIELD
                        .focused($focusedField, equals: .searchParam)
                        .padding(.horizontal, 15)
                        .frame(height: 50)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        .frame(width: metrics.size.width * 0.82, height: 60, alignment: .center)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focusedField = nil
                                }
                            }
                        }
                        HStack {
                            Text("You can type a couple of words to get results based on your input.")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                            Spacer()
                        } //: HSTACK
                    } //: BOX
                    .padding(.top, 35)
                    Button(action: {
                        withAnimation {
                            hapticImpact.impactOccurred()
                            results = true
                        }
                    }) {
                        HStack {
                            Text("Get Recommendation")
                                .font(.title2.weight(.bold))
                        } //: HSTACK
                        .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    } //: BUTTON
                    .foregroundColor(.white)
                    .background(Color("ColorPurple"))
                    .contentShape(Rectangle())
                    .cornerRadius(8)
                    .padding(.vertical, 30)
                } //: VSTACK
                .padding(.horizontal, 20)
                VStack(alignment: .leading, spacing: 8) {
                    if (results) {
                        AppsListView(name: "Recommendation Result 1", chevron: false, fontHeavy: false, hex: "007AAF", image: false)
                            .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: results)
                        AppsListView(name: "Recommendation Result 2", chevron: false, fontHeavy: false, hex: "007AAF", image: false)
                            .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: results)
                        AppsListView(name: "Recommendation Result 3", chevron: false, fontHeavy: false, hex: "007AAF", image: false)
                            .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: results)
                        AppsListView(name: "Recommendation Result 4", chevron: false, fontHeavy: false, hex: "007AAF", image: false)
                            .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: results)
                        AppsListView(name: "Recommendation Result 5", chevron: false, fontHeavy: false, hex: "007AAF", image: false)
                            .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: results)
                    }
                } //: VSTACK
            } //: SCROLL VIEW
            .navigationBarTitle(title, displayMode: .automatic)
        } //: GEOMETRY READER
    }
}

// MARK: - PREVIEW
struct GetRecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        GetRecommendationsView(title: "🎥 Deneme")
    }
}
