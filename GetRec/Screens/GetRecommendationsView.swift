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
    let color: String
    @State private var listItems: Array<String>?
    @State private var searchParam: String = ""
    @State private var results: Bool = false
    @State private var animation: Bool = false
    private enum Field: Int, CaseIterable {
        case searchParam
    }
    @FocusState private var focusedField: Field?
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    @EnvironmentObject var network: Network
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { metrics in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                        .padding(.top, 15)
                    GroupBox {
                        VStack(alignment: .leading, spacing: 8) {
                            TextField(
                                "Search Query",
                                text: $searchParam
                            ) //: TEXTFIELD
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
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
                            .onChange(of: searchParam) { newValue in
                                do {
                                    if (searchParam == "" || searchParam.isEmpty) {
                                        network.suggestions = []
                                    } else {
                                        try network.autoFill(query: searchParam, type: "\(title.components(separatedBy: "s")[0].lowercased())")
                                    }
                                } catch {
                                    print("Error", error)
                                }
                            }
                            ForEach(network.suggestions, id: \.self) { suggestion in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(suggestion)
                                    Divider()
                                }
                                .onTapGesture {
                                    searchParam = suggestion
                                    network.suggestions = []
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
                    .padding(.top, 20)
                    Button(action: {
                        Task {
                            do {
                                hapticImpact.impactOccurred()
                                animation = true
                                network.suggestions = []
                                try await network.getRec(query: searchParam, type: "\(title.components(separatedBy: "s")[0].lowercased())")
                                animation = false
                                withAnimation {
                                    results = true
                                }
                            } catch {
                                print("Error", error)
                            }
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
                    if (animation) {
                        VStack {
                            LoaderView(tintColor: .accentColor, scaleSize: 2.0).padding(.bottom,100)
                        }
                    } else {
                        if (results) {
                            if (title == "Books") {
                                ForEach(network.books, id: \.self) { book in
                                    AppsListView(name: book.title.capitalized, chevron: false, recom: true, hex: color, image: false, info1Name: "Author", info1Detail: book.author, info2Name: "Topic", info2Detail: book.mainTopic, height: 125)
                                        .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: results)
                                }
                            } else if (title == "Movies") {
                                ForEach(network.movies, id: \.self) { movie in
                                    AppsListView(name: movie.title, chevron: false, recom: true, hex: color, image: false, info1Name: "Director", info1Detail: movie.director, info2Name: "Genre", info2Detail: movie.genre, height: 125)
                                        .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: results)
                                }
                            } else if (title == "Games") {
                                ForEach(network.games, id: \.self) { game in
                                    AppsListView(name: game.title, chevron: false, recom: true, hex: color, image: false, info1Name: "Publisher", info1Detail: game.publisher, info2Name: "Genre", info2Detail: game.genres, height: 125)
                                        .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: results)
                                }
                            }
                        }
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
        GetRecommendationsView(title: "🎥 Deneme", color: "9A86A4")
            .environmentObject(Network())
    }
}
