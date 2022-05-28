//
//  SignUpView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/2/22.
//

import SwiftUI
import Combine

struct SignUpView: View {
    // MARK: - PROPERTY
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordRepeat: String = ""
    @State private var passwordMatch: Bool = true
    @State private var isValid: Bool = true
    @AppStorage("screen") var screen: Int = 2
    @AppStorage("return") var isReturn: Bool = false
    private enum Field: Int, CaseIterable {
        case email, password, passwordRepeat
    }
    @FocusState private var focusedField: Field?
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    @ObservedObject var textValidator = TextValidator()
    @EnvironmentObject var network: Network
    @AppStorage("signup_success") var signup_success: Bool = false
    @AppStorage("signup_failure") var signup_failure: Bool = false
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { metrics in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer()
                    HStack {
                        Text("Create an account")
                            .font(.system(size: 45.0).weight(.bold))
                        Spacer()
                    } //: HSTACK
                    .padding(.bottom, 30)
                    TextField(
                        "Username*",
                        text: $username
                    ) //: TEXTFIELD
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .email)
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    .disableAutocorrection(true)
                    .padding(.bottom, 5)
                    .onReceive(Just(username)) { newValue in
                        if username == "" || email == "" || password == "" || passwordRepeat == "" {
                            isValid = false
                        } else {
                            isValid = true
                        }
                    }
                    TextField(
                        "E-mail*",
                        text: $email
                    ) //: TEXTFIELD
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .email)
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    .disableAutocorrection(true)
                    .padding(.bottom, 5)
                    .onReceive(Just(username)) { newValue in
                        if username == "" || email == "" || password == "" || passwordRepeat == "" {
                            isValid = false
                        } else {
                            isValid = true
                        }
                    }
                    SecureInputView(
                        "Password*",
                        text: $password
                    ) //: SECUREINPUTVIEW
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .password)
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    .disableAutocorrection(true)
                    .padding(.bottom, 5)
                    .onReceive(Just(password)) { newValue in
                        if username == "" || email == "" || password == "" || passwordRepeat == "" {
                            isValid = false
                        } else if password != passwordRepeat {
                            passwordMatch = false
                            isValid = false
                        } else {
                            isValid = true
                            passwordMatch = true
                        }
                    }
                    SecureInputView(
                        "Repeat Password*",
                        text: $passwordRepeat
                    ) //: SECUREINPUTVIEW
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .passwordRepeat)
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    .disableAutocorrection(true)
                    .onReceive(Just(passwordRepeat)) { newValue in
                        if username == "" || email == "" || password == "" || passwordRepeat == "" {
                            isValid = false
                        } else if password != passwordRepeat {
                            passwordMatch = false
                            isValid = false
                        } else {
                            isValid = true
                            passwordMatch = true
                        }
                    }
                    if !passwordMatch {
                        HStack {
                            Text("Passwords don't match!")
                                .font(.body)
                                .foregroundColor(Color("ColorRed"))
                            .multilineTextAlignment(.leading)
                            Spacer()
                        } //: HSTACK
                        .padding(.top, 5)
                    } else if (self.signup_failure) {
                        HStack {
                            Text("User already exists!")
                                .font(.body)
                                .foregroundColor(Color("ColorRed"))
                            .multilineTextAlignment(.leading)
                            Spacer()
                        } //: HSTACK
                        .padding(.top, 5)
                    }
                    
                    HStack {
                        Text("By signing up on this app, you're also agreeing to our Terms of Service and Privacy Policy.")
                            .font(.body)
                        .multilineTextAlignment(.leading)
                        Spacer()
                    } //: HSTACK
                    .padding(.vertical, 25)
                    Button(action: {
                        hapticImpact.impactOccurred()
                        Task {
                            do {
                                try await network.signup(username: username, password: password, password_confirm: passwordRepeat, email: email)
                                if (self.signup_success) {
                                    withAnimation {
                                        isReturn = false
                                        screen = 4
                                    }
                                } else if (self.signup_failure) {
                                    username = ""
                                    email = ""
                                    password = ""
                                    passwordRepeat = ""
                                }
                            } catch {
                                print("Error", error)
                            }
                        }
                    }) {
                        HStack {
                            Text("Sign Up")
                                .font(.title2.weight(.bold))
                        } //: HSTACK
                        .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                    } //: BUTTON
                    .foregroundColor(.white)
                    .contentShape(Rectangle())
                    .background((isValid && passwordMatch ) ? Color("ColorPurple") : Color.gray)
                    .cornerRadius(8)
                    .disabled(!isValid || !passwordMatch)
                    HStack {
                        Text("Already have an account?")
                            .font(.body)
                        .multilineTextAlignment(.leading)
                        Button(action: {
                            withAnimation {
                                hapticImpact.impactOccurred()
                                isReturn = false
                                screen = 3
                            }
                        }) {
                            Text("Sign In")
                                .font(.body.weight(.bold))
                        }
                        Spacer()
                    } //: HSTACK
                    .padding(.vertical, 20)
                    //Spacer()
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
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(Network())
    }
}
