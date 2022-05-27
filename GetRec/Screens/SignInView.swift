//
//  SignInView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/2/22.
//

import SwiftUI
import Combine

struct SignInView: View {
    // MARK: - PROPERTY
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isValid: Bool = true
    @AppStorage("screen") var screen: Int = 3
    @AppStorage("return") var isReturn: Bool = false
    private enum Field: Int, CaseIterable {
        case email, password
    }
    @FocusState private var focusedField: Field?
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    @ObservedObject var textValidator = TextValidator()
    @EnvironmentObject var network: Network
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { metrics in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer()
                    HStack {
                        Text("Sign in to your account")
                            .font(.system(size: 45.0).weight(.bold))
                        Spacer()
                    } //: HSTACK
                    .padding(.bottom, 30)
                    TextField(
                        "Username*",
                        text: $username
                    ) //: TEXTFIELD
                    .focused($focusedField, equals: .email)
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    .disableAutocorrection(true)
                    .padding(.bottom, 5)
                    .onReceive(Just(username)) { newValue in
                        if username == "" || password == "" {
                            isValid = false
                        } else {
                            isValid = true
                        }
                    }
                    SecureInputView(
                        "Password*",
                        text: $password
                    ) //: SECUREINPUTVIEW
                    .focused($focusedField, equals: .password)
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    .disableAutocorrection(true)
                    .onReceive(Just(password)) { newValue in
                        if (username == "" || password == "") {
                            isValid = false
                        } else {
                            isValid = true
                        }
                    }
                    if (network.login_failure) {
                        HStack {
                            Text("Username or password is incorrect!")
                                .font(.body)
                                .foregroundColor(Color("ColorRed"))
                            .multilineTextAlignment(.leading)
                            Spacer()
                        } //: HSTACK
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                    }
                    Button(action: {
                        network.login(username: username, password: password)
                        if (network.login_success) {
                            withAnimation {
                                hapticImpact.impactOccurred()
                                isReturn = false
                                screen = 4
                            }
                        }
                    }) {
                        HStack {
                            Text("Sign In")
                                .font(.title2.weight(.bold))
                        } //: HSTACK
                        .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    } //: BUTTON
                    .foregroundColor(.white)
                    .contentShape(Rectangle())
                    .background((isValid) ? Color("ColorPurple") : Color.gray)
                    .cornerRadius(8)
                    .disabled(!isValid)
                    HStack {
                        Text("Don't have an account yet?")
                            .font(.body)
                        .multilineTextAlignment(.leading)
                        Button(action: {
                            withAnimation {
                                hapticImpact.impactOccurred()
                                isReturn = true
                                screen = 2
                            }
                        }) {
                            Text("Sign Up")
                                .font(.body.weight(.bold))
                        }
                        Spacer()
                    } //: HSTACK
                    .padding(.vertical, 15)
                    Spacer()
                } //: VSTACK
                .textFieldStyle(PlainTextFieldStyle())
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
                .font(Font.system(size: 20, design: .default))
                .padding(.horizontal, 20)
                .padding(.top, 100)
            } //: SCROLL VIEW
        } //: GEOMETRY READER
    }
}

// MARK: - PREVIEW
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(Network())
    }
}
