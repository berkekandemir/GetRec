//
//  ContentView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/1/22.
//

import SwiftUI

struct ContentView: View {
    /*
     Screens:
     1 - Onboarding
     2 - Sign Up
     3 - Sign In
     4 - Apps
     5 - Get Recommendations
     6 - Info
     */
    @AppStorage("screen") var screen: Int = 1
    @AppStorage("return") var isReturn: Bool = false
    
    var body: some View {
        ZStack {
            if screen == 1 {
                OnboardingView()
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: !isReturn ? .trailing : .leading), removal: .move(edge: !isReturn ? .leading : .trailing)))
            } else if screen == 2 {
                SignUpView()
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: !isReturn ? .trailing : .leading), removal: .move(edge: !isReturn ? .leading : .trailing)))
            } else if screen == 3 {
                SignInView()
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: !isReturn ? .trailing : .leading), removal: .move(edge: !isReturn ? .leading : .trailing)))
            } else if screen == 4 {
                CategoriesView()
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: !isReturn ? .trailing : .leading), removal: .move(edge: !isReturn ? .leading : .trailing)))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
